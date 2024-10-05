import UIKit


class Person {
    
    deinit {
        print("Person deinit")
    }
}

//Here we are creating a strong reference by referencing to the instance of the class(object)
var person: Person? = Person()             //count = 1

var Anna: Person? = person                 // count + 1
var John: Person? = person                 // count + 1


Anna = nil                                 //count - 1
John = nil                                 //count - 1

person = nil                                //count = 0 // deallocated from memory



//weak reference
weak var person2: Person? = Person()  // if person2 has weak reference, object and the weak references related to object will be deallocated immediately
print("person2 is deallocated")


//unowned reference
unowned var person3: Person? = Person()  // if person3 has unowned reference, only object will be deallocated immediately and not the weak references related to object and it will not increase the count, it might lead to a crash(less safe)
print("person2 is deallocated")
