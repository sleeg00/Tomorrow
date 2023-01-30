package com.example.Tomorrow.Dto;

import java.util.List;

public class ServerInfo {

    public final String name;

    public final List<ServiceInfo> services;


    public ServerInfo(String name, List<ServiceInfo> services) {
        this.name = name;
        this.services=services;
    }
}
