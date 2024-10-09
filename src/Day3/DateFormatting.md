# The Pearls and Pitfalls of DateTime

[summary](https://devoxx.be/talk/the-pearls-and-pitfalls-of-datetime/)

```java
class Sample {
  void main() {
    var format = new DateTimeFormatter();
    format.setLenient(false);
  }
}
```
to avoid errors in time formatting

- python datetime only supports up to microseconds -> lossy conversion
- never work with time zones, let the API people solve it

> oracle tz data versions [link](https://www.oracle.com/java/technologies/tzdata-versions.html)

> time sensitive applications with multiple time zones are horrible