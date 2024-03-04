get:
	flutter pub get
clean:
	flutter clean

format:
	find . -not -path './.git/*' -not -path '*/.dart_tool/*' -not -path '*/lib/l10n/*' -name "*.dart" ! -name "*.g.dart" ! -name "*.gr.dart" ! -name "*_test.dart" ! -name '*.swagger.*' ! -name '*.config.dart' ! -name '*.chopper.dart' ! -name '*.freezed.dart' | tr '\n' ' ' | xargs fvm dart format --line-length=80

fix:
	dart fix --apply

generate:
	flutter packages pub run build_runner build --delete-conflicting-outputs

pods:
	cd ios && arch -x86_64 pod install --repo-update

repair:
	flutter pub cache repair

build:
	dart run build_runner watch