# Astroweb Mobile

## Overview

This is the **mobile version** of Astroweb - a full-stack astrology application built with **Flutter**.

- **Web App**: [astroweb-99-cyber-mystic-astrology](../astroweb-99-cyber-mystic-astrology) (React + Cloudflare Workers)
- **Mobile App**: [astroweb_mobile](./README.md) (Flutter - iOS/Android)

## Quick Links

- [Setup Guide](SETUP.md)
- [Flutter Docs](https://flutter.dev/docs)
- [Astrology Engine](lib/astro_engine/)

## Getting Started

```bash
cd /Users/cao.lv/gitlab.citigo.com.vn/local/astroweb_mobile

# Install dependencies
flutter pub get

# Run app
flutter run
```

## Features

- ✨ 12-house astrology chart
- 🌙 Lunar calendar integration  
- 📱 Cross-platform (iOS + Android)
- 🎨 Dark astrology theme
- 💾 Offline data storage
- 🔄 Sync with web backend

## Architecture

```
Flutter App
├── UI Layer (Material 3)
├── State Management (Riverpod)
├── Data Layer (Hive + HTTP)
└── Astro Engine (Pure Dart)
```

## Development Status

- 🔧 Setup & scaffolding (in progress)
- ⏳ Feature implementation (upcoming)
- ⏳ Testing & optimization (upcoming)

## Related

- **Another Flutter Project**: [a_tuvi](../a_tuvi) - Tử Vi astrology app
