import java.util.ArrayList;
import java.util.HashMap;

public class AddressList {
    private final HashMap<String, ArrayList<Address>> addresses = new HashMap<String, ArrayList<Address>>();
    public HashMap<String, HashMap<Integer, Integer>> buildingsCount = new HashMap<String, HashMap<Integer, Integer>>();
    public ArrayList<Address> duplicates = new ArrayList<Address>();

    public void addAddress(String city, String street, Integer house, Integer floor) {
        Address newAddress = new Address(city, street, house, floor);

        updateBuildingsCount(newAddress);

        if (addresses.containsKey(city)) {
            for (Address address : addresses.get(city))
                if (address.equals(newAddress)) {
                    address.countOfOccurrences++;

                    duplicates.add(address);
                    return;
                }
        }
        else {
            addresses.put(city, new ArrayList<Address>());
        }
        addresses.get(city).add(newAddress);
    }

    private void updateBuildingsCount(Address newAddress) {
        if (buildingsCount.containsKey(newAddress.city)) {
            if (buildingsCount.get(newAddress.city).containsKey(newAddress.floor)) {
                buildingsCount.get(newAddress.city).
                        put(newAddress.floor, buildingsCount.get(newAddress.city).get(newAddress.floor) + 1);
            } else {
                buildingsCount.get(newAddress.city).put(newAddress.floor, 1);
            }
        } else {
            HashMap<Integer, Integer> buildings = new HashMap<Integer, Integer>();
            buildings.put(newAddress.floor, 1);
            buildingsCount.put(newAddress.city, buildings);
        }
    }
}
