package Day2;

import java.awt.Color;
import java.util.function.Function;

public class DecoratorPattern {

  void main() {
    process(Function.identity());
    process(Color::brighter);
    process(Color::darker, Color::darker, Color::darker, Color::brighter);
    process(Color::darker, Color::darker);
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
