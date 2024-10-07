# Enhancing Productivity and Insight: A Tour of JDK Tools Progress Beyond Java 17

[talk link](https://devoxx.be/talk/enhancing-productivity-and-insight-a-tour-of-jdk-tools-progress-beyond-java-17/)
[slides link](https://www.slideshare.net/slideshow/enhancing-productivity-and-insight-a-tour-of-jdk-tools-progress-beyond-java-17-d836/272225158)

## jshell
jshell is shipped with JDK since version 9. It is a REPL (Read-Eval-Print Loop) tool that allows you to execute Java
code snippets and see the results immediately. It is a great tool for learning Java and trying out new features.

## jwebserver
it is a simple web server that can serve static files via GET requests. Simple alternative to a full-fledged web server
like wiremock, or docker compose test setups.

- SimpleFileServer.class can be used to start the server with configuration options

## jpackage
jpackage is a tool that allows you to package your Java application as a platform-specific executable.
- `jpackage --input target --name myapp --main-jar myapp.jar --main-class com.example.Main --type app-image`

## Security Tools
### keytool & jarsigner
- updated options for keytool
- jarsigner can now accept a providerPath and altsigner path flag has been removed

## Profiling and Runtime Management tools
### Technology available
- JFR (Java Flight Recorder)
- JMC (Java Mission Control)
- JFR Event Streaming API

### jfr scrub
- removes sensitive data from JFR recordings
- `jfr scrub --output sanitized.jfr recording.jfr`
- `jfr scrub --output sanitized.jfr --exclude event=java.net.SocketRead event=java.net.SocketWrite recording.jfr`
### jfr view
- view JFR recordings runtime wihtout the need to open JMC

## useful links:
- [dev.java](https://dev.java)
- [youtube.com/Java](https://youtube.com/Java)