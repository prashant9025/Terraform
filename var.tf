/*
variable "a"{
  type=string
}
output "aval"{
 value="${var.a}"
}
variable "b"{
  type=string
  default="testing"
}
output "bval"{
 value="${var.b}"
}
variable "c"{
  type=list
  default=[10,20,30,40,"apple"]
}
output "cval"{
 value="${var.c}"
}
output "cval1"{
 value="${var.c[0]}"
}

output "Noofel"{
 value="${length(var.c)}"
}

*/