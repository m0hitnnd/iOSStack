

infix operator !: TernaryPrecedence
infix operator |: TernaryPrecedence


func |<T1, T2>(lhs: @escaping (T1) -> T2, rhs: @autoclosure @escaping () -> T2) -> (second: (T1) -> T2, third: () -> T2) {
    return (lhs, rhs)
}

func !<T1, T2>(lhs: Optional<T1>, rhs: (second: (T1) -> T2, third: () -> T2)) -> T2 {
    guard let unwrappedLhs = lhs else {
        return rhs.third()
    }
    return rhs.second(unwrappedLhs)
}

let optionalVar: String? = "some value"
let result4: String = optionalVar ! { "We got \($0)" } | "blah"

let anotherOptionalVar: Int? = nil
let result5: String = anotherOptionalVar ! { "\($0)" } | "-1"
