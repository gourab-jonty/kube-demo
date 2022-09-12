resource "aws_iam_role" "iam_role" {
  name               = "${var.name}-role"
  assume_role_policy = file("${path.module}/files/assumerolepolicy.json")
}
resource "aws_iam_policy" "inst_policy" {
  name   = "${var.name}-policy"
  policy = file("${path.module}/files/policy.json")
}
resource "aws_iam_policy_attachment" "role-attach" {
  name       = "Attaching policy"
  roles      = ["${aws_iam_role.iam_role.name}"]
  policy_arn = aws_iam_policy.inst_policy.arn
}
resource "aws_iam_instance_profile" "inst_profile" {
  name = "${var.name}-instance_profile"
  role = aws_iam_role.iam_role.id
}
