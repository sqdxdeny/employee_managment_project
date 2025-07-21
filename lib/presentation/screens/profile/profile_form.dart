part of 'profile_screen.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF12345E), Color(0xFFE5897B), Color(0xFF12345E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Center(
            child: GestureDetector(
              onTap: () async {
                final pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  context.read<ProfileBloc>().add(
                    ProfileEvent.changeImage(pickedFile.path),
                  );
                }
              },
              child: CircleAvatar(
                radius: 60,
                backgroundImage:
                    state.image != null ? FileImage(File(state.image!)) : null,
                child:
                    state.image == null ? Icon(Icons.person, size: 60) : null,
              ),
            ),
          );
        },
      ),

    );
  }
}
