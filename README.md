# Roblox Job System – RoDevs Scripter Role Submission

## Overview

This project is a **Job System** built for Roblox as a demonstration of my scripting capabilities.

The system allows players to:
- Choose between different job roles (like Farmer, Miner)
- Gain XP per job through interaction with a part (can be migrated to a NPC character)
- Level up their job with XP requirements
- Change jobs at any time (XP/Level resets per job)

---

## Features

### Core Systems
- **Modular job logic** in `JobModule.lua`
- **XP and Level system**
- **Data persistence** using `DataStoreService`
- **Event architecture** with `RemoteEvent` and `RemoteFunction`

### UI & Interaction
- Scripted UI elements (not drag-and-drop)
- XP/Level display that updates in real-time
- Job selector GUI to change jobs mid-game
- NPC click interaction to gain XP based on current job

### Multiplayer Support
- Each player has their own save data
- Server tracks job stats separately per player

---

## 🚫 Rule Clarification

Although the system includes UI and click interaction, **it is not a basic UI or simple mechanic.**

It demonstrates:
- Modular design principles
- Persistent player state
- Reusable patterns for expanding to more jobs or roles

This project is designed with scalability in mind — new jobs can be added with just one data table entry and no rewrites.

## 🙌 Thank You

Thanks for reviewing my submission!
