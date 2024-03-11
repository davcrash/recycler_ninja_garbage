import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:garbage_game/src/colors.dart' as colors;
import 'package:garbage_game/src/spacing.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});
  void _goToDashboard(context) {
    Navigator.of(context).pushReplacementNamed(
      "/",
    );
  }

  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _goToDashboard(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios_new),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(right: Spacing.sm)),
                          Text(
                            AppLocalizations.of(context)!.credits,
                            textAlign: TextAlign.center,
                            style: baseTheme.textTheme.headlineLarge?.copyWith(
                              color: baseTheme.colorScheme.primary,
                              shadows: [
                                const Shadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 0.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: Spacing.lg),
                      ),
                      Text(
                        AppLocalizations.of(context)!.font,
                        textAlign: TextAlign.center,
                        style: baseTheme.textTheme.headlineSmall?.copyWith(
                          color: baseTheme.colorScheme.primary,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'https://somepx.itch.io/humble-fonts-free',
                              style: baseTheme.textTheme.titleLarge?.copyWith(
                                color: colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  final Uri url = Uri.parse(
                                    'https://somepx.itch.io/humble-fonts-free',
                                  );
                                  launchUrl(url);
                                },
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: Spacing.lg),
                      ),
                      Text(
                        AppLocalizations.of(context)!.sounds,
                        textAlign: TextAlign.center,
                        style: baseTheme.textTheme.headlineSmall?.copyWith(
                          color: baseTheme.colorScheme.primary,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '1. ',
                              style: baseTheme.textTheme.titleLarge,
                            ),
                            TextSpan(
                              text:
                                  'https://pixabay.com/es/music/video-juegos-kim-lightyear-angel-eyes-chiptune-edit-110226/',
                              style: baseTheme.textTheme.titleLarge?.copyWith(
                                color: colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  final Uri url = Uri.parse(
                                    'https://pixabay.com/es/music/video-juegos-kim-lightyear-angel-eyes-chiptune-edit-110226/',
                                  );
                                  launchUrl(url);
                                },
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: Spacing.xs),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '2. ',
                              style: baseTheme.textTheme.titleLarge,
                            ),
                            TextSpan(
                              text:
                                  'https://pixabay.com/es/sound-effects/movement-swipe-whoosh-4-186578/',
                              style: baseTheme.textTheme.titleLarge?.copyWith(
                                color: colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  final Uri url = Uri.parse(
                                    'https://pixabay.com/es/sound-effects/movement-swipe-whoosh-4-186578/',
                                  );
                                  launchUrl(url);
                                },
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: Spacing.xs),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '3. ',
                              style: baseTheme.textTheme.titleLarge,
                            ),
                            TextSpan(
                              text:
                                  'https://pixabay.com/es/sound-effects/fireball-whoosh-1-179125/',
                              style: baseTheme.textTheme.titleLarge?.copyWith(
                                color: colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  final Uri url = Uri.parse(
                                    'https://pixabay.com/es/sound-effects/fireball-whoosh-1-179125/',
                                  );
                                  launchUrl(url);
                                },
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: Spacing.xs),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '4. ',
                              style: baseTheme.textTheme.titleLarge,
                            ),
                            TextSpan(
                              text:
                                  'https://pixabay.com/es/sound-effects/muffled-distant-explosion-7104/',
                              style: baseTheme.textTheme.titleLarge?.copyWith(
                                color: colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  final Uri url = Uri.parse(
                                    'https://pixabay.com/es/sound-effects/muffled-distant-explosion-7104/',
                                  );
                                  launchUrl(url);
                                },
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: Spacing.xs),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '5. ',
                              style: baseTheme.textTheme.titleLarge,
                            ),
                            TextSpan(
                              text:
                                  'https://pixabay.com/es/sound-effects/90s-game-ui-2-185095/',
                              style: baseTheme.textTheme.titleLarge?.copyWith(
                                color: colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  final Uri url = Uri.parse(
                                    'https://pixabay.com/es/sound-effects/90s-game-ui-2-185095/',
                                  );
                                  launchUrl(url);
                                },
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: Spacing.xs),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '6. ',
                              style: baseTheme.textTheme.titleLarge,
                            ),
                            TextSpan(
                              text:
                                  'https://pixabay.com/es/sound-effects/cute-level-up-3-189853/',
                              style: baseTheme.textTheme.titleLarge?.copyWith(
                                color: colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  final Uri url = Uri.parse(
                                    'https://pixabay.com/es/sound-effects/cute-level-up-3-189853/',
                                  );
                                  launchUrl(url);
                                },
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: Spacing.xs),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '7. ',
                              style: baseTheme.textTheme.titleLarge,
                            ),
                            TextSpan(
                              text:
                                  'https://pixabay.com/es/sound-effects/happy-pop-2-185287/',
                              style: baseTheme.textTheme.titleLarge?.copyWith(
                                color: colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  final Uri url = Uri.parse(
                                    'https://pixabay.com/es/sound-effects/happy-pop-2-185287/',
                                  );
                                  launchUrl(url);
                                },
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: Spacing.xs),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '8. ',
                              style: baseTheme.textTheme.titleLarge,
                            ),
                            TextSpan(
                              text:
                                  'https://pixabay.com/es/sound-effects/boing-2-44164/',
                              style: baseTheme.textTheme.titleLarge?.copyWith(
                                color: colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  final Uri url = Uri.parse(
                                    'https://pixabay.com/es/sound-effects/boing-2-44164/',
                                  );
                                  launchUrl(url);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
