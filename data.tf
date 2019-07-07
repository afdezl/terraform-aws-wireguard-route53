
data "aws_caller_identity" "self" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "automation_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = [
        "ec2.amazonaws.com",
        "ssm.amazonaws.com"
      ]
      type = "Service"
    }
  }
}

data "aws_iam_policy_document" "events_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = [
        "events.amazonaws.com"
      ]
      type = "Service"
    }
  }
}

data "aws_iam_policy_document" "automation_actions" {
  statement {
    actions = [
      "route53:ChangeResourceRecordSets"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ec2:DescribeInstances"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "iam:PassRole"
    ]

    resources = ["${aws_iam_role.events.arn}"]
  }
}

data "aws_iam_policy_document" "allow_automation_invoke" {
  statement {
    actions = [
      "ssm:StartAutomationExecution"
    ]

    resources = [
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.self.account_id}:automation-definition/${aws_ssm_document.register_wireguard_dns.name}:$DEFAULT"
    ]
  }
}
