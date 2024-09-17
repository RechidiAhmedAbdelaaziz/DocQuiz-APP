part of 'home.screen.dart';

class _Drawer extends StatelessWidget {
  const _Drawer({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Drawer(
      backgroundColor: context.colors.background,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            const _DrawerHeader(),
            ...[
              _DrawerItemModel(
                title: 'Tableau de bord',
                icon: Icons.dashboard,
                onTap: cubit.showDashboard,
                isSelected: context.select(
                  (HomeCubit cubit) => cubit.state.isDashboard,
                ),
              ),
              _DrawerItemModel(
                title: 'Paramètres',
                icon: Icons.settings,
                onTap: cubit.showMyQuiz,
                isSelected: context.select(
                    (HomeCubit cubit) => cubit.state.isSetting),
              ),
            ].map((item) => _DrawerItem(item)),
          ],
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        width(30),
        Text(
          'DocQuiz',
          style: context.textStyles.h4,
        ),
        const Spacer(),
        IconButton(
          onPressed: () => context.back(),
          icon: Icon(Icons.close, color: context.colors.dark),
        ),
      ],
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem(this.model, {super.key});

  final _DrawerItemModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        model.onTap();
        context.back();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          color: model.isSelected
              ? context.colors.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            width(20),
            Icon(model.icon, color: context.colors.dark),
            width(20),
            Text(
              model.title,
              style: context.textStyles.h5,
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItemModel {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  const _DrawerItemModel({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isSelected = false,
  });
}
