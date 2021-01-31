#
# IAM group + membership of group
#
data "aws_caller_identity" "current" {}

resource "aws_iam_group" "user_group_dev" {
  name = var.group_name_dev
}

resource "aws_iam_group_membership" "user_group_dev" {
  name  = "${var.group_name_dev}"
  users = var.user_list_dev

  group = aws_iam_group.user_group_dev.name
}

resource "aws_iam_group" "user_group_ops" {
  name = var.group_name_ops
}

resource "aws_iam_group_membership" "user_group_ops" {
  name  = "${var.group_name_ops}"
  users = var.user_list_ops

  group = aws_iam_group.user_group_ops.name
}

#
# IAM policy to allow the user group to assume the role passed to the module
#

// create a test role
data "aws_iam_policy_document" "user_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    # only allow folks in this account
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }
    # only allow folks with MFA
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_iam_role" "test_role" {
  name               = "test-role"
  assume_role_policy = data.aws_iam_policy_document.user_assume_role_policy.json
}

resource "aws_iam_group_policy_attachment" "assume_role_policy_attachment_dev" {
  group = aws_iam_group.user_group_dev.name
  #  policy_arn = aws_iam_policy.assume_role_policy.arn
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "assume_role_policy_attachment_ops" {
  group = aws_iam_group.user_group_ops.name
  #  policy_arn = aws_iam_policy.assume_role_policy.arn
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}


