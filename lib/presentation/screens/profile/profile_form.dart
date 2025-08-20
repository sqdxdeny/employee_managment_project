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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF12345E), Color(0xFFE5897B), Color(0xFF12345E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: BlocBuilder<ProfileEditorBloc, ProfileEditorState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.all(15)),
                  GestureDetector(
                    onTap: () async {
                      final pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedFile != null) {
                        context.read<ProfileEditorBloc>().add(
                          ProfileEditorEvent.changeImage(pickedFile.path),
                        );
                      }
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          state.image != null
                              ? FileImage(File(state.image!))
                              : null,
                      child:
                          state.image == null
                              ? Icon(Icons.person, size: 60)
                              : null,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hoverColor: Colors.red,
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person, color: Colors.white),
                            hintText: '*Current Login*',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.key_outlined,
                              color: Colors.white,
                            ),
                            hintText: '***********',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 60),
                    ],
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Save changes'),
                      style: ButtonStyle(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
