package org.example;

import com.google.gson.*;
import com.pengrad.telegrambot.TelegramBot;
import com.pengrad.telegrambot.UpdatesListener;
import com.pengrad.telegrambot.model.Update;
import com.pengrad.telegrambot.request.SendMessage;
import com.pengrad.telegrambot.response.SendResponse;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.TimeZone;

public class Bot {
    TelegramBot bot;
    String TIMEZONE = "Europe/Moscow";
    String INVALID_COMMAND_MESSAGE = "Invalid command. Try again";
    String INVALID_GROUP_NUMBER_MESSAGE = "Group number must consist of 4 digits";
    String INVALID_WEEK_NUMBER_MESSAGE = "Week number must be either 1 for odd or 2 for even";
    String INVALID_DAY_NAME_MESSAGE = "Invalid day name. \nVariants: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday";
    List<String> daysOfWeek = List.of(new String[] {
            "monday",
            "tuesday",
            "wednesday",
            "thursday",
            "friday",
            "saturday",
            "sunday"
    });

    public Bot() {
        String token = System.getenv("LetiSkedHeadBotToken");
        if (token == null) {
            throw new RuntimeException("Token is not found in environment variable 'LetiSkedHeadBotToken'");
        }
        bot = new TelegramBot(token);
    }

    public void start() {
        bot.setUpdatesListener(updates -> {
            for (Update update : updates) {
                processUpdate(update);
            }
            return UpdatesListener.CONFIRMED_UPDATES_ALL;
        });
    }

    private void processUpdate(Update update) {
        if (update.message() == null) return;
        String text = update.message().text().trim();

        Calendar datetime = new Calendar.Builder()
                .setInstant(update.message().date() * 1000L)
                .setTimeZone(TimeZone.getTimeZone(TIMEZONE))
                .build();

        String response_text = INVALID_COMMAND_MESSAGE;

        if (text.matches("next for [0-9]+")) {
            response_text = nextLessonCommand(text, datetime);
        } else if (text.matches("day [a-zA-Z]+ week [0-9]+ for [0-9]+")) {
            response_text = dayCommand(text);
        } else if (text.matches("tomorrow for [0-9]+")) {
            response_text = tomorrowCommand(text, datetime);
        } else if (text.matches("week [0-9]+ for [0-9]+")) {
            response_text = weekCommand(text);
        }

        System.out.println(response_text);

        long chatId = update.message().chat().id();
        SendResponse response = bot.execute(new SendMessage(chatId, response_text));

        if (!response.isOk()) {
            System.out.println("Telegram api connection error: " + response.errorCode());
        }
    }

    private String nextLessonCommand(String text, Calendar datetime) {
        String[] words = text.split("\\s+");

        String groupNumber = words[2];
        if (groupNumberIsInvalid(groupNumber)) return INVALID_GROUP_NUMBER_MESSAGE;

        String week = String.valueOf(datetime.get(Calendar.WEEK_OF_YEAR) % 2);
        String today = String.valueOf((datetime.get(Calendar.DAY_OF_WEEK) - 2));

        String scheduleJson = LetiSchedule.getWeekSchedule(groupNumber);
        if (scheduleJson.equals("{}")) return "Cannot find group " + groupNumber;

        JsonObject days = getDays(scheduleJson, groupNumber);

        byte currentHour = (byte) datetime.get(Calendar.HOUR_OF_DAY);
        byte currentMinute = (byte) datetime.get(Calendar.MINUTE);
        String nextLesson = "";
        String result = "";

        int daysToSearch = 14;
        for (int i = 0; i < daysToSearch && nextLesson.isEmpty(); i++) {
            JsonObject day = days.get(today).getAsJsonObject();
            JsonArray lessons = day.get("lessons").getAsJsonArray();
            nextLesson = getNextLessonForToday(lessons, week, currentHour, currentMinute);
            result = nextLesson + " (" + day.get("name").getAsString() + ")";

            today = String.valueOf((Integer.parseInt(today) + 1));
            if (today.equals("7")) {
                today = "0";
                week = week.equals("1") ? "2" : "1";
            }
            currentHour = 0;
            currentMinute = 0;
        }

        System.out.println(result);
        return result;
    }

    private String tomorrowCommand(String text, Calendar datetime) {
        String[] words = text.split("\\s+");

        String groupNumber = words[2];
        if (groupNumberIsInvalid(groupNumber)) return INVALID_GROUP_NUMBER_MESSAGE;

        String week = String.valueOf(datetime.get(Calendar.WEEK_OF_YEAR) % 2);
        String tomorrow = String.valueOf((datetime.get(Calendar.DAY_OF_WEEK) - 1));
        if (tomorrow.equals("0")) {
            week = week.equals("1") ? "2" : "1";
        }

        String scheduleJson = LetiSchedule.getWeekSchedule(groupNumber);
        if (scheduleJson.equals("{}")) return "Cannot find group " + groupNumber;

        JsonObject days = getDays(scheduleJson, groupNumber);
        JsonObject day = days.get(tomorrow).getAsJsonObject();

        return getDayLessons(day, week);
    }

    private String dayCommand(String text) {
        String[] words = text.split("\\s+");

        String dayName = words[1].toLowerCase();
        if (dayNameIsInvalid(dayName)) return INVALID_DAY_NAME_MESSAGE;
        String weekNumber = words[3];
        if (weekNumberIsInvalid(weekNumber)) return INVALID_WEEK_NUMBER_MESSAGE;
        String groupNumber = words[5];
        if (groupNumberIsInvalid(groupNumber)) return INVALID_GROUP_NUMBER_MESSAGE;

        String scheduleJson = LetiSchedule.getWeekSchedule(groupNumber);
        if (scheduleJson.equals("{}")) return "Cannot find group " + groupNumber;

        JsonObject days = getDays(scheduleJson, groupNumber);
        JsonObject day = days.get(Integer.toString(daysOfWeek.indexOf(dayName))).getAsJsonObject();

        return getDayLessons(day, weekNumber);
    }

    private String weekCommand(String text) {
        String[] words = text.split("\\s+");

        String weekNumber = words[1];
        if (weekNumberIsInvalid(weekNumber)) return INVALID_WEEK_NUMBER_MESSAGE;
        String groupNumber = words[3];
        if (groupNumberIsInvalid(groupNumber)) return INVALID_GROUP_NUMBER_MESSAGE;

        String scheduleJson = LetiSchedule.getWeekSchedule(groupNumber);
        if (scheduleJson.equals("{}")) return "Cannot find group " + groupNumber;

        return getWeekSchedule(scheduleJson, groupNumber, weekNumber);
    }

    private JsonObject getDays(String scheduleJson, String groupNumber) {
        Gson gson = new GsonBuilder().create();
        return gson.fromJson(scheduleJson, JsonObject.class)
                .get(groupNumber).getAsJsonObject()
                .get("days").getAsJsonObject();
    }

    private String getWeekSchedule(String scheduleJson, String groupNumber, String weekNumber) {
        JsonObject days = getDays(scheduleJson, groupNumber);
        StringBuilder schedule = new StringBuilder();
        JsonObject day;

        for (int i = 0; i < 7; i++) {
            day = days.get(Integer.toString(i)).getAsJsonObject();
            schedule
                    .append(getDayLessons(day, weekNumber))
                    .append("\n");
        }

        return schedule.toString();
    }

    private boolean groupNumberIsInvalid(String groupNumber) {
        return groupNumber.length() != 4;
    }

    private boolean weekNumberIsInvalid(String weekNumber) {
        return !weekNumber.matches("[1-2]");
    }

    private boolean dayNameIsInvalid(String dayName) {
        return !daysOfWeek.contains(dayName);
    }

    private String getNextLessonForToday(JsonArray lessons, String week, byte currentHour, byte currentMinute) {
        SimpleDateFormat sdf;
        Calendar tmp = new Calendar.Builder().build();
        JsonObject lesson;
        byte lessonHour;
        byte lessonMinute;

        for (int i = 0; i < lessons.size(); i++) {
            lesson = lessons.get(i).getAsJsonObject();
            if (lesson.getAsJsonObject().get("week").getAsString().equals(week)) {
                sdf = new SimpleDateFormat("HH:mm");

                try {
                    tmp.setTime(sdf.parse(lesson.get("start_time").getAsString()));
                } catch (ParseException e) {
                    throw new RuntimeException(e);
                }

                lessonHour = (byte) tmp.get(Calendar.HOUR_OF_DAY);
                lessonMinute = (byte) tmp.get(Calendar.HOUR_OF_DAY);

                if (lessonHour > currentHour || (lessonHour == currentHour && lessonMinute > currentMinute)) {
                    return getLessonString(lesson);
                }
            }
        }

        return "";
    }

    private String getDayLessons(JsonObject day, String weekNumber) {
        StringBuilder schedule = new StringBuilder();
        JsonArray lessons = day.get("lessons").getAsJsonArray();
        JsonObject lesson;

        String dayName = day.get("name").toString();
        schedule.append(dayName.replace("\"", ""))
                .append(":\n");

        byte lessonNumber = 1;
        for (int i = 0; i < lessons.size(); i++) {
            lesson = lessons.get(i).getAsJsonObject();
            if (lesson.getAsJsonObject().get("week").getAsString().equals(weekNumber)) {
                schedule.append(lessonNumber).append(". ")
                        .append(getLessonString(lesson))
                        .append("\n");
                lessonNumber++;
            }
        }

        return schedule.toString();
    }

    private String getLessonString(JsonObject lesson) {
        StringBuilder schedule = new StringBuilder();

        String name = lesson.get("name").getAsString();
        String subjectType = lesson.get("subjectType").getAsString();
        String teacher = lesson.get("teacher").getAsString();
        String start = lesson.get("start_time").getAsString();
        String end = lesson.get("end_time").getAsString();

        schedule.append("Lesson: ")
                .append(name.replace("\"", ""))
                .append(" (")
                .append(subjectType.replace("\"", ""))
                .append(")")
                .append("\n    Teacher: ")
                .append(teacher.replace("\"", ""))
                .append("\n    Time: ")
                .append(start.replace("\"", ""))
                .append(" - ")
                .append(end.replace("\"", ""));

        return schedule.toString();
    }
}