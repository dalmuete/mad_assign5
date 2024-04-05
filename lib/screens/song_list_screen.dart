import 'package:flutter/material.dart';
import 'package:assign_5/providers/song_provider.dart';
import 'package:provider/provider.dart';
import 'package:assign_5/screens/song_player_screen.dart';

class SongListScreen extends StatelessWidget {
  final List<Map<String, String>> songs = [
    {
      "title": "Attack on Titan - So ist es immer",
      "path":
          "assets/musics/Attack on Titan - _So ist es immer_ with Lyrics(MP3_128K).mp3",
      "image": "assets/images/aot_so_ist_es_immer.jpg",
      "artist": "Hiroyuki Sawano",
    },
    {
      "title": "Attack on Titan - Shock",
      "path":
          "assets/musics/Attack On Titan Season 4 Ending -  [SHOCK] - Yūko Andō _ Lyrics (English_Rōmaji_日本語)(MP3_128K).mp3",
      "image": "assets/images/aot_shock.jpg",
      "artist": "Yuko Ando",
    },
    {
      "title": "Attack on Titan - Call Your Name",
      "path": "assets/musics/Call your name(MP3_128K).mp3",
      "image": "assets/images/aot_call_your_name.jpg",
      "artist": "Hiroyuki Sawano",
    },
    {
      "title": "Attack on Titan - Akuma no Ko",
      "path":
          "assets/musics/ヒグチアイ _ 悪魔の子【Official Video】Ai Higuchi_Akuma no Ko_Attack on Titan The Final Season Part 2 ED theme(MP3_128K).mp3",
      "image": "assets/images/aot_akuma_no_ko.jpg",
      "artist": "Ai Higuchi",
    },
    {
      "title": "Dr. Stone - Good Morning World!",
      "path":
          "assets/musics/BURNOUT SYNDROMES 『Good Morning World_』Music Video.mp3",
      "image": "assets/images/dr_stone_op.jpg",
      "artist": "BURNOUT SYNDROMES",
    },
    {
      "title": "Dr. Stone - Life",
      "path":
          "assets/musics/Dr. STONE - Ending Full『LIFE』by Rude(MP3_128K).mp3",
      "image": "assets/images/dr_stone_life.jpg",
      "artist": "Rude",
    },
    {
      "title": "Dr. Stone - Suki ni Shinayo",
      "path":
          "assets/musics/Dr. STONE New World Part 2 Ending Theme FULL - 『Suki ni Shinayo』 by Anly(MP3_128K).mp3",
      "image": "assets/images/dr_stone_end.jpg",
      "artist": "Anly",
    },
    {
      "title": "Oksihina",
      "path":
          "assets/musics/Dionela - Oksihina (Official Lyric Video)(MP3_70K).mp3",
      "image": "assets/images/oksihina.jpg",
      "artist": "Dionela",
    },
    {
      "title": "Bling Bang Bang Born",
      "path":
          "assets/musics/MASHLE_ MAGIC AND MUSCLES Season 2 - Opening FULL _Bling-Bang-Bang-Born_ by Creepy Nuts (Lyrics)(MP3_128K).mp3",
      "image": "assets/images/bling-bang-bang-born.jpg",
      "artist": "Creepy Nuts",
    },
    {
      "title": "Anata no Soba ni",
      "path":
          "assets/musics/My Happy Marriage _ Opening - Anata no Soba ni by Riria (Full Version with Lyrics)(MP3_128K).mp3",
      "image": "assets/images/anata_no_soba_ni.jpg",
      "artist": "Riria",
    },
    {
      "title": "Haru(Sunny)",
      "path": "assets/musics/ヨルシカ - 晴る(MP3_128K).mp3",
      "image": "assets/images/sunny.jpg",
      "artist": "Yorushika",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorites'),
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
            color: Color.fromARGB(96, 255, 255, 255),
            fontWeight: FontWeight.w500),
      ),
      backgroundColor: Colors.grey.shade900,
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return Card(
            color: Colors.grey.shade800,
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 8),
              leading: ClipRRect(
              borderRadius: BorderRadius.circular(7),
                child: Image.asset(
                  song["image"]!,
                  width: 60,
                  height: 100,
                  fit: BoxFit.fitWidth,
                ),
              ),
              title: Text(
                song["title"]!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                song["artist"]!,
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                final songProvider =
                    Provider.of<SongProvider>(context, listen: false);
                songProvider.play(song["path"]!);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SongPlayerScreen(
                      songTitle: song["title"]!,
                      songImage: song["image"]!,
                      songPath: song["path"]!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
