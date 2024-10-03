part of 'home.screen.dart';

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return SafeArea(
      child: Drawer(
        backgroundColor: context.colors.background,
        child: Column(
          children: [
            const _DrawerHeader(),
            height(5),
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
                title: 'Mes Quiz',
                icon: Icons.quiz,
                onTap: cubit.showMyQuiz,
                isSelected: context.select(
                    (HomeCubit cubit) => cubit.state.isMyQuiz),
              ),
              _DrawerItemModel(
                title: 'Créer un Quiz',
                icon: Icons.playlist_add,
                onTap: cubit.showCreateQuiz,
                isSelected: context.select(
                    (HomeCubit cubit) => cubit.state.isCreateQuiz),
              ),
              _DrawerItemModel(
                title: 'Playlist',
                icon: Icons.playlist_play_rounded,
                onTap: cubit.showPlayList,
                isSelected: context.select(
                    (HomeCubit cubit) => cubit.state.isPlayList),
              ),
              _DrawerItemModel(
                title: 'Série d\'examens',
                icon: Icons.school,
                onTap: cubit.showExam,
                isSelected: context
                    .select((HomeCubit cubit) => cubit.state.isExam),
              ),
            ].map((item) => _DrawerItem(item)),
          ],
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(12.r),
        ),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(AppIcons.logo, height: 55.h),
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Image.asset(AppIcons.name, height: 45.h),
          ),
          const Spacer(),
          InkWell(
            onTap: () => context.back(),
            child: Icon(Icons.arrow_back_ios_rounded,
                color: Colors.black, size: 25.h),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem(this.model);

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
            if (model.isSelected)
              Container(
                width: 3.w,
                height: 35.h,
                margin: EdgeInsets.only(right: 10.w),
                color: context.colors.dark,
              ),
            Icon(model.icon, color: context.colors.dark, size: 33.h),
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
