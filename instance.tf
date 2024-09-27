resource "aws_instance" "instance" {
  tags = {
    Name = "prod-instance"
  }
  key_name               = "oregon"
  instance_type          = "t2.micro"
  ami                    = "ami-033067239f2d2bfbc"
  subnet_id              = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.mysg.id]

}
