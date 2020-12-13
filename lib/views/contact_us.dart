import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  TextEditingController _name = new TextEditingController();
  TextEditingController _subject = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _message = new TextEditingController();



  Future<void> sendDataToEmail ()async
  {
    String username = 'smslegends@gmail.com';
    String password = 'waqas614';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'WaqasNews')
      ..recipients.add('${_email.text}')
      ..subject = 'WaqasNews Contact Form :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = """
      <!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>HSE</title>
  <style>
    html,
    body,
    table,
    tbody,
    tr,
    td,
    div,
    p,
    ul,
    ol,
    li,
    h1,
    h2,
    h3,
    h4,
    h5,
    h6 {
      margin: 0;
      padding: 0;
    }

    body {
      margin: 0;
      padding: 0;
      font-size: 0;
      line-height: 0;
      -ms-text-size-adjust: 100%;
      -webkit-text-size-adjust: 100%;
    }

    table {
      border-spacing: 0;
      mso-table-lspace: 0pt;
      mso-table-rspace: 0pt;
    }

    table td {
      border-collapse: collapse;
    }

    .ExternalClass {
      width: 100%;
    }

    .ExternalClass,
    .ExternalClass p,
    .ExternalClass span,
    .ExternalClass font,
    .ExternalClass td,
    .ExternalClass div {
      line-height: 100%;
    }
    /* Outermost container in Outlook.com */

    .ReadMsgBody {
      width: 100%;
    }

    img {
      -ms-interpolation-mode: bicubic;
    }

    h1,
    h2,
    h3,
    h4,
    h5,
    h6 {
      font-family: Arial;
    }

    h1 {
      font-size: 28px;
      line-height: 32px;
      padding-top: 10px;
      padding-bottom: 24px;
    }

    h2 {
      font-size: 24px;
      line-height: 28px;
      padding-top: 10px;
      padding-bottom: 20px;
    }

    h3 {
      font-size: 20px;
      line-height: 24px;
      padding-top: 10px;
      padding-bottom: 16px;
    }

    p {
      font-size: 16px;
      line-height: 20px;
      font-family: Georgia, Arial, sans-serif;
    }

    </style>
    <style>

      .container600 {
        width: 600px;
        max-width: 100%;
      }

    @media all and (max-width: 599px) {
      .container600 {
        width: 100% !important;
      }
    
      .smarttable {
        border: 0px;
      }
      .smarttable thead {
        display:none;
        border: none;
        height: 0px;
        margin: 0px;
        overflow: hidden;
        padding: 0px;
        max-width:0px;
        max-height:0px;
      }
      .smarttable tr {
        display: block;
        width:90%;
        margin:20px auto;
      }
      .smarttable td {
        border-bottom: 1px solid #ddd;
        display: block;
        font-size: 15px;
        text-align: center;
      }
    }
  </style>

   <!--[if gte mso 9]>
        <style>
            .ol {
              width: 100%;
            }
        </style>
    <![endif]-->

</head>
<body style="background-color:#F4F4F4;">
    
</body>
</html>
      """;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Waqas",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[

        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30,right: 30,top: 20,bottom: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2
          ),
          color: Colors.grey[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MediaQuery.of(context).size.width/4),
            bottomRight: Radius.circular(MediaQuery.of(context).size.width/4),
          )
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(15),
            children: [
              Padding(padding: EdgeInsets.only(bottom: 15),
              child: Text("Contact Us",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500
              ),),),
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _subject,
                decoration: InputDecoration(
                  hintText: "Subject",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _phone,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Phone",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _message,
                minLines: 4,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Message",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor
                      )
                  ),
                ),
              ),
              SizedBox(height: 10,),
              MaterialButton(
                height: 50,
                onPressed: sendDataToEmail,
                child: Text("Send Message",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),

    );
  }
}
