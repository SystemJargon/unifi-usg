Steps

1) Open /usr/sbin/unifi-video in your favorite text editor

2) Locate this portion of the file:

[ -e /dev/urandom ] && \
        JVM_EXTRA_OPTS="-Djava.security.egd=file:/dev/./urandom ${JVM_EXTRA_OPTS}"

JVM_OPTS="${JVM_EXTRA_OPTS} \
 -Xmx${JVM_MX} \
 -Xss${JVM_STACKSIZE_MX} \


3) Insert this new line...


  JVM_EXTRA_OPTS="-Dlog4j2.formatMsgNoLookups=true ${JVM_EXTRA_OPTS}"


// NOT THIS LINE OR ANYTHING FURTHER, THE NEXT FEW LINES SHOULD EXIST ALREADY

[ -e /dev/urandom ] && \
        JVM_EXTRA_OPTS="-Djava.security.egd=file:/dev/./urandom ${JVM_EXTRA_OPTS}"

JVM_EXTRA_OPTS="-Dlog4j2.formatMsgNoLookups=true ${JVM_EXTRA_OPTS}"

JVM_OPTS="${JVM_EXTRA_OPTS} \
 -Xmx${JVM_MX} \
 -Xss${JVM_STACKSIZE_MX} \

4) Save the file, exit the text editor, and run service unifi-video restart

That should be all you need to do. I would hope that Ubiquiti would consider releasing an update since this isn't exactly a difficult mitigation.


Original Source https://community.ui.com/questions/Mitigating-the-Java-Log4J-exploit-in-UniFi-Video-on-Debian-Ubuntu/c59621d2-3cbf-48aa-9780-76477e0b1d39
