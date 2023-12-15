package org.example;

import com.pengrad.telegrambot.model.User;

import java.sql.*;

public class DB {
    String jdbcUrl = "jdbc:postgresql://localhost:5432/LetiSkedHead";
    Connection connection;
    public DB() {
        String password = System.getenv("LetiSkedHeadDBPassword");
        if (password == null) {
            throw new RuntimeException("Password is not found in environment variable 'LetiSkedHeadDBPassword'");
        }
        try {
            connection = DriverManager.getConnection(
                    jdbcUrl,
                    "postgres",
                    password
            );
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void insertUserIfNotExist(User user, String group) {
        int groupNumber = Integer.parseInt(group);
        String statement = String.format(
                "insert into users (tg_id, username, firstname, lastname, group_number) values (%d, '%s', '%s', '%s', %d) " +
                        "on conflict (tg_id) do update " +
                        "set username = excluded.username, " +
                        "firstname = excluded.firstname, " +
                        "lastname = excluded.lastname," +
                        "group_number = excluded.group_number;",
                user.id(), user.username(), user.firstName(), user.lastName(), groupNumber
        );

        try {
            PreparedStatement query = connection.prepareStatement(statement);
            query.execute();
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
    }

    public String getGroupForUser(User user) {
        String statement = String.format("select group_number from users where tg_id=%d", user.id());

        String groupNumber = "";
        try {
            PreparedStatement query = connection.prepareStatement(statement);
            ResultSet result = query.executeQuery();
            result.next();
            groupNumber = result.getString("group_number");
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }

        return groupNumber;
    }
}
