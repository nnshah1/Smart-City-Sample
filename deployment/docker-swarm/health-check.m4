
    defn(`OFFICE_NAME')_health_check:
        image: smtc_trigger_health:latest
        volumes:
            - /etc/localtime:/etc/localtime:ro
        environment:
            SERVICE_INTERVAL: "30"
            OFFICE: "defn(`OFFICE_LOCATION')"
            DBHOST: "http://ifelse(eval(defn(`NOFFICES')>1),1,defn(`OFFICE_NAME')_db,db):9200"
            NO_PROXY: "*"
            no_proxy: "*"
ifelse(defn(`PLATFORM'),`VCAC-A',`dnl
        networks:
            - default_net
')dnl
        deploy:
            placement:
                constraints:
                    - defn(`OFFICE_ZONE')
