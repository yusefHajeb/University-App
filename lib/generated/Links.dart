//this is Links
// const String {Constants.serverIp} = "http://192.168.1.10";
import 'package:university/core/constant/varibal.dart';

//const String {Constants.serverIp} = "http://10.0.2.2";
// const String linkPuplicServerName = "http://10.0.2.2";
const String linkServerName = "${Constants.serverIp}/Universty_Chat_PHP";
const String linkConectedServer =
    "http://10.0.2.2/Universty_Chat_PHP/checkServerConnection.php";
// const String linkgetAllUsers = "$linkServerName/user/getAllUsers.php";
// const String linkgetAllGoups = "$linkServerName/group/getGroups.php";
// const String linkgetMessageGoups = "$linkServerName/group/getMessage.php";
const String linkSignin = "$linkServerName/auth/SignInUsers.php";
const String linkGetCurrentUId = "$linkServerName/auth/getCurrentUId.php";
// const String linkHome = "$linkServerName/image.php";
// const String linkImageRootImage = "${Constants.serverIp}/UniversitySystem/StudentsImage";
const String linkImageRootImageGruop =
    "${Constants.serverIp}/UniversitySystem/imageGuops";
const String linkHome = "$linkServerName/image.php";

// const String linkImageRootImageChat = "${Constants.serverIp}/UniversitySystem/ChatMadia";
// const String linksendMessageGoups =
//     "$linkServerName/group/messageGroup/add_message.php";
// const String linklastMessageGoups =
//     "${Constants.serverIp}/group/messageGroup/last_message_group.php";

// const String link_update_state = "$linkServerName/update_on_stateLecture.php";
// const String link_select_notific =
//     "$linkServerName/Notification/GetNotific.php";
// const String linkCountNewMessageGoups =
//     "$linkServerName/group/messageGroup/count_message_new.php";
//////////////////////////////////////

const String linkPuplicNodeServerName = "${Constants.serverIp}:3000";
const String linkCurrentStudent =
    "${Constants.linkPuplicNodeServerName}/CurrentStudent";
const String linkNodegetMessageGoups =
    "${Constants.linkPuplicNodeServerName}/getmessages";
const String linkNodeGetCurrentSId =
    "${Constants.linkPuplicNodeServerName}/CurrentStudent";
const String linkNodeSignin = "${Constants.linkPuplicNodeServerName}/signIn";
const String linkUplodeNode =
    linkPuplicNodeServerName + "/uploadImageForChatgroup";
const String NodelinksendMessageGoups =
    "${Constants.linkPuplicNodeServerName}/addMessage";
const String NodelinkupdateMessageGoups =
    "$linkPuplicNodeServerName/updateMessage";
const String NodelinkdeleteMessageGoups =
    "$linkPuplicNodeServerName/deleteMessage";
const String linkaudioRootChat =
    "${Constants.serverIp}/UniversitySystem/ChatMadia";
const String linkUpdatetoken =
    linkPuplicNodeServerName + "/UpdateTokenForStudent";
