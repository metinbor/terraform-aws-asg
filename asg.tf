data "template_file" "init" {
template = "${file("${path.module}/wordpress.sh")}"
}

resource "aws_launch_template" "example" {
  name_prefix   = "example"
  image_id      = "${data.aws_ami.image.id}"
  instance_type = "c5.large"
  user_data = "${base64encode(data.template_file.init.rendered)}"
  key_name    =  "${aws_key_pair.us-east-1-key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.asg_sec_group.id}"]
}

resource "aws_autoscaling_group" "example" {
  name = "terraform-asg-example"
  launch_configuration = "${aws_launch_template.example.name}"

  availability_zones = [
    "${var.region}a",
    "${var.region}b",
    "${var.region}c",
  ]

  desired_capacity = "${var.desired_capacity}"
  max_size         = "${var.max_size}"
  min_size         = "${var.min_size}"

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = "${aws_launch_template.example.id}"
      }

      override {
        instance_type     = "c4.large"
        weighted_capacity = "3"
      }

      override {
        instance_type     = "c3.large"
        weighted_capacity = "2"
      }
    }
  }
}

