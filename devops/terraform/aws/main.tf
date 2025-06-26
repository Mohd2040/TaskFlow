# devops/terraform/aws/main.tf

# 1. تعريف VPC (الشبكة الخاصة الافتراضية)
resource "aws_vpc" "taskflow_vpc" {
  cidr_block = "10.0.0.0/16" # نطاق IP لـ VPC
  tags = {
    Name = "${var.project_name}-VPC"
  }
}

# 2. تعريف Subnet عام داخل VPC
resource "aws_subnet" "taskflow_public_subnet" {
  vpc_id                  = aws_vpc.taskflow_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true # لتعيين Public IP تلقائياً للخوادم
  availability_zone       = "${var.aws_region}a" # ✅ استخدم المنطقة المتوفرة لديك (us-west-1a)
  tags = {
    Name = "${var.project_name}-PublicSubnet"
  }
}

# 3. تعريف Internet Gateway (بوابة الإنترنت)
resource "aws_internet_gateway" "taskflow_igw" {
  vpc_id = aws_vpc.taskflow_vpc.id
  tags = {
    Name = "${var.project_name}-IGW"
  }
}

# 4. تعريف جدول التوجيه (Route Table) وتوجيه حركة الإنترنت
resource "aws_route_table" "taskflow_public_rt" {
  vpc_id = aws_vpc.taskflow_vpc.id
  route {
    cidr_block = "0.0.0.0/0" # توجيه كل حركة المرور إلى الإنترنت
    gateway_id = aws_internet_gateway.taskflow_igw.id
  }
  tags = {
    Name = "${var.project_name}-PublicRT"
  }
}

# 5. ربط جدول التوجيه بالـ Subnet العام
resource "aws_route_table_association" "taskflow_public_rt_assoc" {
  subnet_id      = aws_subnet.taskflow_public_subnet.id
  route_table_id = aws_route_table.taskflow_public_rt.id
}

# 6. تعريف مجموعة الأمان (Security Group)
resource "aws_security_group" "taskflow_sg" {
  name        = "${var.project_name}-SecurityGroup"
  description = "Allow SSH, HTTP, and HTTPS traffic"
  vpc_id      = aws_vpc.taskflow_vpc.id

  # السماح بـ SSH (Port 22) من أي مكان
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # السماح بـ HTTP (Port 80) من أي مكان
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # السماح بـ HTTPS (Port 443) من أي مكان
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # السماح بكل حركة المرور الصادرة (Outbound)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 يعني جميع البروتوكولات
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-SG"
  }
}

# 7. تعريف EC2 Instance (الخادم الافتراضي)
resource "aws_instance" "taskflow_backend_server" {
  ami           = var.ami_id # AMI ID من المتغيرات
  instance_type = var.instance_type # نوع الخادم من المتغيرات
  subnet_id     = aws_subnet.taskflow_public_subnet.id
  vpc_security_group_ids = [aws_security_group.taskflow_sg.id] # ربط مجموعة الأمان
  key_name      = var.ssh_key_name # اسم مفتاح SSH للوصول إلى الخادم

  tags = {
    Name = "${var.project_name}-BackendServer"
    Environment = "Dev"
  }
}

# 8. تعريف Elastic IP (عنوان IP عام ثابت)
resource "aws_eip" "taskflow_eip" {
  vpc        = true
  instance   = aws_instance.taskflow_backend_server.id # ربط الـ EIP بالخادم
  tags = {
    Name = "${var.project_name}-EIP"
  }
}
