package org.example;

import okhttp3.HttpUrl;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import java.io.IOException;

public class LetiSchedule {
    public static String getWeekSchedule(String groupNumber) {
        HttpUrl httpUrl = new HttpUrl.Builder()
                .scheme("https")
                .host("digital.etu.ru")
                .addPathSegment("api")
                .addPathSegment("mobile")
                .addPathSegment("schedule")
                .addQueryParameter("groupNumber", groupNumber)
                .build();

        Request requestHttp = new Request.Builder()
                .url(httpUrl)
                .build();

        System.out.println("ULR: " + requestHttp);

        OkHttpClient httpClient = new OkHttpClient();
        try (Response response = httpClient.newCall(requestHttp).execute()) {
            if (response.body() != null) {
                return response.body().string();
            }
        } catch (IOException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return "";
    }
}
