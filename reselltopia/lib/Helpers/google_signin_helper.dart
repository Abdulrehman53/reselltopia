/*
void handleLogin(SharedPreferences sharedPreferences) async {
  sharedPreferences = await SharedPreferences.getInstance();
  setState(() {
    isLoading = true;
  });
  GoogleSignInAccount signInAccount = await googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await signInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final FirebaseUser user = await firebaseAuth.signInWithCredential(credential);
  if (user != null) {
    final QuerySnapshot querySnapshot = await Firestore.instance
        .collection("user")
        .where("id", isEqualTo: user.uid)
        .getDocuments();
    final List<DocumentSnapshot> userList = querySnapshot.documents;
    if (userList.length == 0) {
      Firestore.instance.collection("user").document(user.uid).setData({
        id: user.uid,
        name: user.displayName,
        picture: user.photoUrl,
      });
      await sharedPreferences.setString(id, user.uid);
      await sharedPreferences.setString(id, user.displayName);
      await sharedPreferences.setString(id, user.photoUrl);
      Fluttertoast.showToast(msg: 'Logged in successfully');
      setState(() {
        isLoading = false;
      });
    } else {
      await sharedPreferences.setString(id, userList[0][id]);
      await sharedPreferences.setString(id, userList[0][name]);
      await sharedPreferences.setString(id, userList[0][picture]);
    }
  }
}
*/
