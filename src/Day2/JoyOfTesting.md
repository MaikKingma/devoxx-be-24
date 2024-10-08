# The joy of testing

[summary](https://devoxx.be/talk/the-joy-of-testing/)

Good watch to get a basic understanding of unit testing and why a developer should write tests.

## why write tests?

- Regression & safe refactoring
- pass quality gates -> coverage rush
- up to date specification
- prove it works
- fast feedback
- clarify requirements
- design feedback: hard to test means poor design

## Qualities of a test

- sensible
- functional
- specific
- expressive
- automated
- repeatable
- isolated
- minimal

## flavours of coverage

- line
- branch

> Tab driven development :-D

> Use test coverage to hunt for uncovered code not celebrate covered code

- possibility to use json for classes with many fields

## mutation testing

- change the code and see if the test fails
- if they don't fail we have a problem

**pitest:** pit reporting is a tool that can be used for mutation testing. it changes the byte code of a part of
your code and then runs the tests. if the tests fail, the mutation is killed. if the tests pass, the mutation is not
killed, and you receive a report of the mutations that were not killed.

downside: takes ages to run. limit to critical code

> REALLY WANT TO TRY THIS OUT.

## Cobra effect

mockito usage without using mock or verify, mock getters and setters but no assert args whatsoever

## 6 stages of debugging

1. that can't happen
2. that doesn't happen on my machine
3. that shouldn't happen
4. why does that happen?
5. oh, I see
6. how did that ever work?

## Fix a bug like a pro

1. reproduce the bug
2. write a test that fails
3. add log.debug or log.trace and avoid breakpoints from there on
4. fix the bug

> 80% of bugs lies in 20% of the code

> never copy code from production to your tests.

## test naming

AnActiveCustomer.beActivatedWithValidData
given should

```java
class Test {
  public void test() {
    var fellowship = List.of(new Fellow("Frodo", 28, "Hobbit"),
        new Fellow("Gandalf", 2019, "Wizard"),
        new Fellow("Aragorn", 87, "Human"));

    assertThat(fellowship)
        .extracting(Fellow::getName, Fellow::getAge, Fellow::getRace)
        .containsExactlyInAnyOrder(
            tuple("Frodo", 28, "Hobbit"),
            tuple("Gandalf", 2019, "Wizard"),
            tuple("Aragorn", 87, "Human"));
  }
}
```

## assertThat extension

reference to other talk Spring testing from zero to hero where he wrote custom extension function for assertThat() form
AssertJ

## TDD

instead of religious rigourous approach, use it as a tool to help you design your code and test in early stages. not
necessarily to write tests first. write tests when you know what you want to test.

> write parameterized tests when test pattern is repetitive

## Parameterized tests

> use records as argument source to identify the argument fields and avoid too many Parameters in the test method
> signature

**Best Praciteces**

- orthogonal test cases (low multicollienarity)
- few parameters < 3-5
- avoid boolean riddled tests

## Testing styles

- output based: assert result
- state based: assert state of object fields after method call or external states like DB state
- interaction based: assert that a method was called with certain arguments (collaborators)

## Approval testiing

write test cases with test input and bogus test output assertions, then verify the actual output with business and when
all is good update the test output.

## BDD
[Writing tests is fun with spok](https://www.youtube.com/watch?v=YzhIyF836-A&ab_channel=BarcelonaJug)
- cucumber
- JBehave
- Spok
- and so on







