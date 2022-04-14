# Newer Method

First, let’s take a backup of the jar we’re going to modify:

```
cd /usr/lib/unifi-video/lib
cp log4j-core-2.1.jar /root/log4j-core-2.1.jar.bak
```

Next, let’s remove the JndiLookup class from the log4j-core package:

```zip -q -d log4j-core-*.jar org/apache/logging/log4j/core/lookup/JndiLookup.class```

Restart Unifi Video as normal:

```
service unifi-video restart
```

## What This Does ##

This patches the JAR file used by Unifi Video itself to not include the lookup class at all. This class, as far as I am aware, is the source of the vulnerable code. This removes the class entirely from the log4j library.



Source: https://www.veracode.com/blog/security-news/urgent-analysis-and-remediation-guidance-log4j-zero-day-rce-cve-2021-44228

------------------------------
# Older Method

Steps

1) Open /usr/sbin/unifi-video in your favorite text editor

2) Locate this portion of the file:

[ -e /dev/urandom ] && \
        JVM_EXTRA_OPTS="-Djava.security.egd=file:/dev/./urandom ${JVM_EXTRA_OPTS}"

JVM_OPTS="${JVM_EXTRA_OPTS} \
 -Xmx${JVM_MX} \
 -Xss${JVM_STACKSIZE_MX} \


3) Insert this new line... This is around line 231 in the file

```
  JVM_EXTRA_OPTS="-Dlog4j2.formatMsgNoLookups=true ${JVM_EXTRA_OPTS}"
```

THE NEXT FEW LINES SHOULD EXIST ALREADY

[ -e /dev/urandom ] && \
        JVM_EXTRA_OPTS="-Djava.security.egd=file:/dev/./urandom ${JVM_EXTRA_OPTS}"

JVM_EXTRA_OPTS="-Dlog4j2.formatMsgNoLookups=true ${JVM_EXTRA_OPTS}"

JVM_OPTS="${JVM_EXTRA_OPTS} \
 -Xmx${JVM_MX} \
 -Xss${JVM_STACKSIZE_MX} \

4) Save the file, exit the text editor, and run 
```
service unifi-video restart
```

## What this does

/usr/sbin/unifi-video is a pretty long wrapper script for starting the Java process, MongoDB process, and some other processes to make Unifi Video work. We add the log4j2.formatMsgNoLookups=true option to JVM when it starts the Unifi Video JAR, which effectively mitigates the vulnerability.

Source https://community.ui.com/questions/Mitigating-the-Java-Log4J-exploit-in-UniFi-Video-on-Debian-Ubuntu/c59621d2-3cbf-48aa-9780-76477e0b1d39
