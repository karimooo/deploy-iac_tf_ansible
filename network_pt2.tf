#Initiate Peering connection request from eu-west-3
resource "aws_vpc_peering_connection" "euwest3-euwest1" {
  provider    = aws.region-master
  peer_vpc_id = aws_vpc.vpc_master_ireland.id
  vpc_id      = aws_vpc.vpc_master.id
  peer_region = var.region-worker

}

#Accept VPC peering request in eu-west-1 from eu-west-3
resource "aws_vpc_peering_connection_accepter" "accept_peering" {
  provider                  = aws.region-worker
  vpc_peering_connection_id = aws_vpc_peering_connection.euwest3-euwest1.id
  auto_accept               = true
}

#Create route table in eu-west-3
resource "aws_route_table" "internet_route" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_master.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  route {
    cidr_block                = "192.168.1.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.euwest3-euwest1.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "Master-Region-RT"
  }
}

#Overwrite default route table of VPC(Master) with our route table entries
resource "aws_main_route_table_association" "set-master-default-rt-assoc" {
  provider       = aws.region-master
  vpc_id         = aws_vpc.vpc_master.id
  route_table_id = aws_route_table.internet_route.id
}

#Create route table in eu-west-1
resource "aws_route_table" "internet_route_ireland" {
  provider = aws.region-worker
  vpc_id   = aws_vpc.vpc_master_ireland.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-ireland.id
  }
  route {
    cidr_block                = "10.0.1.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.euwest3-euwest1.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "Worker-Region-RT"
  }
}

#Overwrite default route table of VPC(Worker) with our route table entries
resource "aws_main_route_table_association" "set-worker-default-rt-assoc" {
  provider       = aws.region-worker
  vpc_id         = aws_vpc.vpc_master_ireland.id
  route_table_id = aws_route_table.internet_route_ireland.id
}
