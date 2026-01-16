package com.library.model;

public class Room {
    private int id;
    private String name;
    private int capacity;
    private String status;

    public Room(int id, String name, int capacity, String status) {
        this.id = id;
        this.name = name;
        this.capacity = capacity;
        this.status = status;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public int getCapacity() { return capacity; }
    public String getStatus() { return status; }
}