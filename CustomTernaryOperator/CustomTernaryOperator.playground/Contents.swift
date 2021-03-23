
// Custom Ternary Operator
infix operator !: TernaryPrecedence
infix operator |: TernaryPrecedence


func |<T1, T2>(
    lhs: @escaping (T1) -> T2,
    rhs: @autoclosure @escaping () -> T2
) -> (second: (T1) -> T2, third: () -> T2) {
    return (lhs, rhs)
}

func !<T1, T2>(
    lhs: Optional<T1>,
    rhs: (second: (T1) -> T2, third: () -> T2)
) -> T2 {
    guard let unwrappedLhs = lhs else {
        return rhs.third()
    }
    return rhs.second(unwrappedLhs)
}

let nextTask: String? = "Complete Blog"
let result = nextTask ! { "1 new task - \($0)" } |  "No new task" 
