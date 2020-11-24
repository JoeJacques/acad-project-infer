# create sec group
# resource "aws_security_group" "sec_group" {
#   vpc_id =aws_vpc.main.id
  
#   ingress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
  
#   tags = {
#     Name = "acad-ritesh-joe-sg"
#     Owner = "acad-ritesh-joe"
#   }
# }