The sample scans the specified IP block for any IP cameras. If found, they will be registered to the database and be invoked by analytic instances for streaming.

### Sensor Simulation

The sample will simulate camera feeds if there is any MP4 files under the [../volume/simulated](../volume/simulated) directory. The MP4 files must be encoded with H.264 baseline/main profile and AAC if there is audio. If you change any files under [../volume/simulated](../volume/simulated), please restart the sample services.    

### ONVIF Camera Discovery

The sample implements the ONVIF protocol to discover IP cameras on the specified IP range and port range. To activate the ONVIF camera discovery, modify the camera discovery service block as follows in [office.m4](../deployment/docker-swarm/office.m4), and restart the sample:     

```
    defn(`OFFICE_NAME')_camera_discovery:
        image: smtc_onvif_discovery:latest
        environment:
            IP_SCAN_RANGE: "192.168.1.0/24"
            PORT_SCAN_RANGE: "554-8554"
            ...
```

where ```192.168.1.0/24``` is the IP camera subnet, and ```554-8554``` is the IP camera RTSP port range.    

To activate IP camera scanning as well as using simulated cameras, use the following service block declaration:   

```
    defn(`OFFICE_NAME')_camera_discovery:
        image: smtc_onvif_discovery:latest
        environment:
            IP_SCAN_RANGE: "defn(`OFFICE_NAME')_simulated_cameras 192.168.1.0/24"
            PORT_SCAN_RANGE: "11000-eval(11000+defn(`NCAMERAS')*100),554-8554"
            ...
```

