[Open in Swift Playgrounds](https://developer.apple.com/ul/sp0?url=https://captainyukinoshitahachiman.github.io/Cryptography-and-Privacy/feed.json)
# Cryptography & Privacy
## WWDC19 Swift Playgrounds 
> Tell us about the features and technologies you used in your Swift playground.

The playground book I have created for this year's WWDC is called Cryptography & Privacy. I created this in order to tell users the most basic knowledge in cryptography, so that they can be aware of their online privacy. It discusses the importance of privacy first in the introduction cutscene first, then tells the concepts of symmetric and asymmetric cryptograph, and finally provides a practice in real, requiring the user to implement the "secure chat" feature in an imaginary app.

To implement the features above, these frameworks/techniques are used:

- HTML5 + CSS3 + JavaScript
- UIKit
- Security
- CommonCrypto
- PlaygroundSupport
- Markup

The web technologies, well, are actually auto-generated using Hype. With the help, I created the introduction cutscene.

UIKit is used to create live views. I made custom views by subclassing from UIView and did some custom drawing. I created a live view to show users how the messages are transferred so that they can experience it more clearly.

Security and CommonCrypto are used for implementing the cryptography stuff. I checked the Apple Developer Documentations and StackOverflow to learn them.

PlaygroundSupport, obviously, is used to control the the playground book. But this playground is far more than that. By using PlaygroundSupport, this playground book takes advantage of always-on live views, meaning it can be even more interactive, and therefore is enabled to provide better user experience. Completions in the Shortcut Bar are also customized, which gives the user a clean way to code. Moreover, the last page supports all the execution modes, which can help user skip the live view animation or slow down it so that they can understand them better.

And finally, all the contents telling about the cryptography concepts are written in Markup.

## Beyond WWDC19

> If you've shared or considered sharing your coding knowledge and enthusiasm for computer science with others, let us know.

I love coding and computer science, and I love sharing them with others so that more people can benefit from and love it.

I have recently come to the international department of a school, seeking to go to the USA to learn more about CS in the future. And here, I met my new teachers and got to help them using my coding and CS knowledge.

We have an AI course at our school, which tells us how to use Python3 and TensorFlow. Occasionally, last year I attended 2018@Swift, the biggest Swift conference in China Mainland, and there I learned Swift for TensorFlow and its advantages over TensorFlow with Python. I shared this with my teacher and he was very happy to learn about that.

Also at our school, every morning we read after a record of a vocabulary list created by our ESL teacher to practice our English. However, the way she created the audio file was time-consuming and ineffective:

Every time, she opened the online Merriam-Webster Dictionary webpage, started recording on her iPhone, looked up the definition of each word, clicked on the pronunciation button, counted the interval for 3 seconds, and repeated this hundreds of times. (Sometimes we can even hear the notification sound and the chattering in her office!)

Obviously, that seemed terrible to us since we all know what automation is. Once I knew how she made the audio, I told her that it could be done using programming. When I got home, I made a simple macOS app for her called Pronunciation Generator, which receives a word list input, fetches Merriam-Webster Dictionary API and combines the audio for each word. In order to help other teachers, it is now open source on GitHub. What’s more, I recommended Markdown and Shortcuts to her in order to help automate her teaching workflow. I shared my shortcut used to generate a markdown file containing word definitions with her, and I’m sure this will be of great help in her teaching.

Additionally, I taught her how to use secure chat in Telegram to ensure her privacy. (I often recommend this IM app to my friends.) She was really excited after hearing about it, and told me that for she’s a religious minority in China Mainland, she has been unable to talk about religion with her friends on WeChat because of the existence of censorship.

For the same reason, to protect people’s privacy, I created the playground Cryptography & Privacy for this year’s WWDC Scholarship. I do hope this playground can help people learn something about cryptography, so that they can understand how their data are protected and then be aware of their privacy.

Last but not least, let me talk about something beyond WWDC. I have been looking forward to being a WWDC Scholar since I knew it in primary school, and I’m seeking to learn more about app development there so that I can use my knowledge to solve problems and help others.

## Apps on the App Store 2019
So far, I have had one app on the App Store, which is called "BirthReminder". It is open source on GitHub under AGPLv3, and there are 3 contributors besides me. I have made 195 commits (21,630 ++ 12,630 --) to the repo, while the sum of those made by the other three is 31 commits (2,384 ++ 1,578 --). If you think this is not entirely created by me as an individual, please just ignore the following part.

This app enables users to get reminded when their favorite ACG characters are on their birthday. Here, ACG stands for anime, comics, and games. ACG characters are those who appear in ACG works. You may wonder if this makes any sense or not to remind people of the characters' birthdays: That's because ACG culture enthusiasts usually have a weird habit that is celebrating their favorite characters' birthday. In most cases, we may just post a tweet, while sometimes there're people doing it even more enthusiastically. However, sometimes we may not remember the birthdays clearly, so the idea came to my head and I made this app.

This app also has a backend application, which is also written in Swift using Perfect framework. The backend offers to-go birthday information for users to add to their local app, so that they can do it more conveniently. What's more, I've been attempting to rewrite the backend using Vapor. You can find the two backend applications together with the iOS app on my GitHub: https://github.com/CaptainYukinoshitaHachiman

Additionally, besides simply reminding the birthday, I personally think that the app has a deeper value. Nowadays, many people treat ACG works as products only, consume them without thinking but only for fun, and then forget about them soon after consuming, while I treat them as a form of art seriously and hope more people can have the similar idea. By reminding people the ACG characters' birthdays, BirthReminder may get to remind people of the ACG works they enjoyed, the lively and lovely characters, the valuable thoughts inside of them, and the beauty of them, and that probably is what I would like to do most as an ACG enthusiast.
