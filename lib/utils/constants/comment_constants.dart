import 'dart:math';

class Comment {
  Comment({
    required this.userName,
    required this.profileImage,
    required this.content,
    required this.dateTime,
  });

  final String profileImage;
  final String userName;
  final String content;
  final DateTime dateTime;
}

class CommentConstants {
  Comment get comment => Comment(
        userName: randomUsername,
        profileImage: randomImageUrl,
        content: randomComment,
        dateTime: DateTime.now().add(Duration(
          days: Random().nextInt(10),
          hours: Random().nextInt(24),
          minutes: Random().nextInt(60),
        )),
      );

  String get randomImageUrl => _imagesUrl[Random().nextInt(_imagesUrl.length)];
  String get randomUsername => _usernames[Random().nextInt(_usernames.length)];
  String get randomComment => _comments[Random().nextInt(_comments.length)];

  final List _imagesUrl = [
    "https://scontent-ams2-1.cdninstagram.com/v/t39.30808-6/438170807_891438749686785_8636976099513390441_n.jpg?se=7&stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xMDgweDEwODAuc2RyLmYzMDgwOCJ9&_nc_ht=scontent-ams2-1.cdninstagram.com&_nc_cat=1&_nc_ohc=nXsiAOgBl0cQ7kNvgEwrs_7&edm=APs17CUAAAAA&ccb=7-5&ig_cache_key=MzM2MzU0MzU2NzUwNDY1MTA1OA%3D%3D.2-ccb7-5&oh=00_AfC8eJonkswl72b9ppj0I1_ate0soQl2oXyknAZ3-RSTyw&oe=6642321A&_nc_sid=10d13b",
    "https://images.unsplash.com/photo-1662321189467-89d08536809d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
    "https://images.unsplash.com/photo-1662755900173-9d72b6e3a836?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNjR8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662850886700-4ec19bd30d11?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662969351359-1b73ba5347d9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxM3x8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662911484272-e5296fa47cf7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyNHx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1661956602116-aa6865609028?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwyOHx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662948391946-ab57966b3b8f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzNXx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662897586386-11264f7b0b55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0M3x8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662955676669-c5d141718bfd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3OHx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662837625427-970713d74aa6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw4OHx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662933170614-c713579f00c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw4OXx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662659512304-9d23f030c127?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxODF8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60"
        "https://images.unsplash.com/photo-1662908187167-84a9a1559e6c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw5MXx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662959698616-9bb3fa474903?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw5M3x8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60"
        "https://images.unsplash.com/photo-1662837055748-efea54b38eed?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMjR8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662829138009-625bd8709f53?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMjV8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662829169965-cbfe11705ed1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMzB8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662873049320-ad309eed8b83?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMzN8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662845364626-196408576daf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNDR8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662827408552-ae0825420ca5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNTJ8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662695090012-24ccea960995?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNzR8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662755674523-d44bdadb4a0f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxODR8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662496167390-2006fed3bf45?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxODZ8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662755900582-cda7a7e89cc1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxOTZ8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662714953016-d74194e300dc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxOTd8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1662756775438-cc660ee0014e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyNTJ8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1615898290837-e9e8cdc3a7fc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=658&q=80",
    "https://images.unsplash.com/photo-1631982690223-8aa4be0a2497?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80",
    "https://images.unsplash.com/photo-1496217590455-aa63a8350eea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDF8fGRyZXNzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNob2V8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
    "https://images.unsplash.com/photo-1559334417-1adb87b6e97f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
    "https://images.unsplash.com/photo-1594035910387-fea47794261f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
    "https://images.unsplash.com/photo-1714685953638-41a5dae77ea0?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1613323593608-abc90fec84ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1551021794-03be4ddaf67d?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  ];

  final List<String> _usernames = [
    "Harpal Singh",
    "Aman Gupta",
    "Anjali",
    "Rahul Sharma",
    "Rohit Kumar",
    "Rajesh Kumar",
    "Rupali Jangir"
        "Rajesh Sharma",
    "Rahul Kumar",
    "Praveen",
    "Sneha",
    "Rajesh Singh",
    "Himanshu Khanna",
    "Akshay Kumar",
    "Mohit Yadav",
    "Vishal",
  ];

  final List<String> _comments = [
    "Wow! This is amazing! I've never seen anything like it.",
    "Great work! You can really see the effort put into this.",
    "This is so cool! It's really unique and interesting. I love this! It's really captivating and engaging.",
    "This is fantastic! It's really well done and professional.",
    "Incredible job! This is some of the best work I've seen.This is impressive! You should be very proud of this.",
    "Keep up the good work! I can't wait to see what you do next.",
    "This is just perfect! It's really well balanced and thought out. This is too good! I can't believe how well this turned out.",
    "This is truly outstanding! It's clear you're very talented.",
    "This is really something special! It's very memorable and impactful.",
    "This is top-notch! It's very high quality and well crafted.",
    "This is really something else! It's very innovative and creative.",
    "This is really remarkable! It's very distinctive and original.",
    "Wow! This is amazing! I've never seen anything like it. Great work! You can really see the effort put into this.",
    "This is so cool! It's really unique and interesting.",
    "I love this! It's really captivating and engaging.",
    "This is fantastic! It's really well done and professional. Incredible job! This is some of the best work I've seen.",
    "This is impressive! You should be very proud of this.",
    "Keep up the good work! I can't wait to see what you do next.",
    "This is just perfect! It's really well balanced and thought out.",
    "This is too good! I can't believe how well this turned out. This is truly outstanding! It's clear you're very talented.",
    "This is really something special! It's very memorable and impactful.",
    "This is top-notch! It's very high quality and well crafted.",
    "This is really something else! It's very innovative and creative.",
    "This is really remarkable! It's very distinctive and original. I'm blown away by this! It's truly a masterpiece.",
    "This is absolutely stunning! I'm speechless.",
    "This is so inspiring! It's really touched me.",
    "This is beyond amazing! It's truly a work of art.",
    "This is breathtaking! I can't take my eyes off it. This is so mesmerizing! It's really caught my attention.",
    "This is so striking! It's really made an impact on me.",
    "This is so beautiful! It's really a sight to behold.",
    "This is so captivating! I can't stop looking at it. This is so enchanting! It's really drawn me in.",
    "This is so fascinating! I can't get enough of it.",
    "This is so intriguing! It's really piqued my interest. This is so magnificent! It's really a marvel to behold.",
    "This is so splendid! It's really a joy to see.",
    "This is so wonderful! It's really a delight to behold."
  ];
}
