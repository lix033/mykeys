import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<UserCredential> signInWithGoogle() async {
  // Demande à l'utilisateur de sélectionner un compte Google
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  // Si l'utilisateur annule la sélection du compte, retourne null
  if (googleUser == null) {
    throw FirebaseAuthException(
      code: 'account-selection-canceled',
      message: 'La sélection du compte Google a été annulée',
    );
  }

  // Récupère les informations d'authentification de l'utilisateur Google
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  // Crée les informations d'identification pour l'utilisateur dans Firebase
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  try {
    // Connecte l'utilisateur à Firebase avec les informations d'identification Google
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'account-exists-with-different-credential') {
      // L'utilisateur existe déjà avec un autre compte d'authentification
      // Affiche un message d'erreur ou propose de fusionner les comptes
      throw FirebaseAuthException(
        code: 'account-exists-with-different-credential',
        message:
            'L\'utilisateur existe déjà avec un autre compte d\'authentification',
      );
    } else if (e.code == 'invalid-credential') {
      // Les informations d'identification Google sont invalides ou expirées
      // Affiche un message d'erreur ou invite l'utilisateur à se reconnecter
      throw FirebaseAuthException(
        code: 'invalid-credential',
        message:
            'Les informations d\'identification Google sont invalides ou expirées',
      );
    } else {
      // Une erreur inattendue s'est produite lors de la connexion
      // Affiche un message d'erreur ou enregistre l'erreur dans les journaux
      throw FirebaseAuthException(
        code: 'unexpected-error',
        message: 'Une erreur inattendue s\'est produite lors de la connexion',
      );
    }
  } catch (e) {
    // Une erreur inattendue s'est produite lors de la connexion
    // Affiche un message d'erreur ou enregistre l'erreur dans les journaux
    throw FirebaseAuthException(
      code: 'unexpected-error',
      message: 'Une erreur inattendue s\'est produite lors de la connexion',
    );
  }
}
