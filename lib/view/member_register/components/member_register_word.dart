import 'package:flutter/material.dart';

class MemberRegisterWord extends StatelessWidget {
  const MemberRegisterWord({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '동아리를 등록하기 전에\n',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          TextSpan(
            text: '우학동',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          TextSpan(
            text: '에 가입해야 해요',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }
}
