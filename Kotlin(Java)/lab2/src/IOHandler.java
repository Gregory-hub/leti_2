import java.io.*;
import java.util.Scanner;

public class IOHandler {

    /** Starts loop that takes from user a path to scv or xml file, analyses it and writes result to console
     'quit' exits the loop */
    public void run() {
        AddressList addresses = new AddressList();

        String input = getUserInput();
        while (!input.equals("quit")) {
            System.out.println("Running...\n");
            try {
                 addresses = readFile(input);
            } catch (IllegalArgumentException e) {
                System.out.println("Illegal filename");
            } catch (FileNotFoundException e) {
                System.out.println("File not found");
            }

            printResult(addresses);

            input = getUserInput();
        }
    }

    private String getUserInput()
    {
        System.out.print("\nTo quit enter 'quit'\n");
        System.out.print("Enter path to file(.csv or .xml): ");

        Scanner in = new Scanner(System.in);

        return in.nextLine();
    }

    private AddressList readFile(String fileName) throws IllegalArgumentException, FileNotFoundException {
        int i = fileName.lastIndexOf('.');
        if (i == -1) {
            throw new IllegalArgumentException();
        }
        String extension = fileName.substring(i + 1);

        Parser parser = switch (extension) {
            case "csv" -> new CsvParser();
            case "xml" -> new XmlParser();
            default -> throw new IllegalArgumentException();
        };

        return parser.parse(fileName);
    }

    private void printResult(AddressList addresses) {
        for (Address address : addresses.duplicates) {
            System.out.println(address.city + ": " + address.countOfOccurrences);
        }
    }
}
