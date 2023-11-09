public class Address {
    public String city;
    public String street;
    public Integer house;
    public Integer floor;
    public Integer countOfOccurrences;

    Address(String city, String street, Integer house, Integer floor) {
        this.city = city;
        this.street = street;
        this.house = house;
        this.floor = floor;
        countOfOccurrences = 1;
    }

    @Override
    public boolean equals(Object o) {
        if (o == this) {
            return true;
        }

        if (!(o instanceof Address a)) {
            return false;
        }

        return this.city.equals(a.city) &&
                this.street.equals(a.street) &&
                this.house.equals(a.house) &&
                this.floor.equals(a.floor);
    }
}