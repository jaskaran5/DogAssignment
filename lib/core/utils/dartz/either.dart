// 1. Use 'sealed' - this tells Dart exactly which subclasses exist
sealed class Either<L, R> {
  const Either();

  // The 'fold' method is still great for returning values
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
    return switch (this) {
      Left(value: var l) => onLeft(l),
      Right(value: var r) => onRight(r),
    };
  }
}

// 2. Simple Subclasses
class Left<L, R> extends Either<L, R> {
  final L value;
  const Left(this.value);
}

class Right<L, R> extends Either<L, R> {
  final R value;
  const Right(this.value);
}

// 3. Optional Extensions for mapping
extension EitherX<L, R> on Either<L, R> {
  Either<L, R2> map<R2>(R2 Function(R r) fn) =>
      fold((l) => Left(l), (r) => Right(fn(r)));
}
