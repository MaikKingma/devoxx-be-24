# Java design patterns revisited

by Venkat Subramaniam

[summary]()
[video}()

## Optionals

1. Return a reference if the value exists for certain
2. Return an optional is the vlaue may or may not exist
3. Do not use optional<T> for fields
4. Do not use optional<T> for method parameters

## Iterator patterns

### external iterators

For loops are external iterators. The iterator is controlled by the client code. The client code decides when to move to
the next element.

```java
public static void main(String[] args) {
  var names = List.of("John", "Freddy", "Sam");
  for (int i = 0; i < names.size(); i++) {
    System.out.println(names.get(i));
  }

// or (more concise syntax)

  for (var name : names) {
    System.out.println(name);
  }
}

```

### internal iterators

interal iterators are controlled by the collection itself. The client code only needs to provide the operation to be
performed on each element.

```java
public static void main(String[] args) {
  var names = List.of("John", "Freddy", "Sam");
  names.forEach(System.out::println);
}
```

## Factory Pattern

known pattern, no summary needed

## Strategy Pattern

this pattern means that you can define a family of algorithms, encapsulate each one, and make them interchangeable.
Strategy lets the algorithm vary independently of clients that use it.

```java
import java.util.function.Predicate;

class Sample {
  public static void main(String[] args) {
    var numbers = List.of(4, 6, 2, 45, 21, 32, 1, 5, 6, 7, 8, 9, 10);
    printNumbers(numbers, Strategy::test);
  }

  public void printNumbers(List<Integer> numbers, Predicate<Integer> predicate) {
    numbers.forEach(number -> {
      if (predicate.test(number)) System.out::println
    });
  }

  static class Strategy implements Predicate<Integer> {
    public static boolean test(Integer i) {
      return i % 2 == 0;
    }
  }
}
```

## Passing parameters to functions

- applicative order
- normal oder (is rather unusual / rare) used in haskell for example (-> Lookup "lazy evaluation")

```java
class Sample {

  public static void operate(int value) {
    if (Math.random() > 0.5) {
      System.out.println(value);
    } else {
      System.out.println("Not printing the value");
    }
  }

  public static void operateNormal(Supplier<Integer> supplier) {
    if (Math.random() > 0.5) {
      System.out.println(supplier.get());
    } else {
      System.out.println("Not printing the value");
    }
  }

  public static int compute(int value) {
    System.out.println("slow compute called");
    return value * 2;
  }

  public static void main(String[] args) {
    operate(compute(5)); // slow compute called
    operateNormal(() -> compute(5)); // normal order where function compute is only called if really required. In Haskell out of the box
  }
}
```

## Decorator Pattern

the decorator pattern is a structural pattern that allows adding new functionality to an existing object without
altering its structure. This pattern creates a decorator class that wraps the original class and provides additional
functionality keeping class methods signature intact.

```java
package Day2;

import java.awt.Color;
import java.util.function.Function;

public class DecoratorPattern {

  void main() {
    process(Function.identity());
    process(Color::brighter);
    process(Color::darker, Color::darker, Color::darker, Color::brighter);
    process(Color::darker, Color::darker);
//    prints:
//    java.awt.Color[r=255,g=200,b=0]
//    java.awt.Color[r=255,g=255,b=0]
//    java.awt.Color[r=122,g=97,b=0]
//    java.awt.Color[r=124,g=98,b=0]
  }

  @SafeVarargs
  private static void process(Function<Color, Color>... filters) {
    Camera camera = new Camera(filters);
    Color photo = camera.takePhoto(Color.ORANGE);
    System.out.println(photo.toString());
  }

  static class Camera {
    Function<Color, Color> filter;

    public Camera() {
      this.filter = Function.identity();
    }

    @SafeVarargs
    public Camera(Function<Color, Color>... filters) {
      this.filter = Function.identity();
      for (var aFilter : filters) {
        this.filter = this.filter.andThen(aFilter);
      }
    }

    public Color takePhoto(Color color) {
      return filter.apply(color);
    }
  }
}
```





