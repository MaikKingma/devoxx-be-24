# Concurrency in Spring Boot Applications: Making the Right Choice

[summary](https://devoxx.be/talk/concurrency-in-spring-boot-applications-making-the-right-choice/)

## Futures

## CompletableFutures

## Combine vs Compose

## Reactive Programming
for reactive the whole stack needs to be reactive. makes no sense for CPU intensive tasks.

## Virtual Threads
PLatform threads are expensive, so we can use virtual threads to reduce the cost of creating threads.
- Not effective for CPU intensive tasks.
- Caching data in ThreadLocal doesnt work anymore (Jackson)
- Does not work out of the box with HttpRequest or apache Http client
- Can increase the load on target services

- recommendations:
  - avoid sync blocks in favor of ReentrantLock
  - protect external sources form overloading
  - dont use thread pools to limit concurrency
  - prefer virtual threads for blocking IO tasks

## structed concurrency
upcoming release in spring boot - good for interrelated tasks

photophotos
