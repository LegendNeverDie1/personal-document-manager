# Personal Document Manager

A modern offline-first document vault built with Flutter.

This application allows users to organize, store, and manage documents locally using a recursive folder structure similar to a file explorer.

---

# Features

## Recursive Folder System

Create unlimited nested folders.

Example:

Finance
 └── Banks
      └── SBI
           └── Statements

---

## Document Support

Currently supported document types:

- PDF
- Images
- Text Notes

---

## Local Offline Storage

All files are stored locally on the device.

No cloud dependency.

---

## Editable Text Notes

Create and edit text notes directly inside the app.

Notes are stored as `.txt` files locally.

Features:
- Auto-save
- Persistent storage
- Activity tracking

---

## Modern Explorer UI

- Dark theme
- Minimal design
- Card-based layout
- Recursive navigation
- Activity timestamps

---

## Activity Tracking

Folders and documents support:

- createdAt
- updatedAt

Recursive timestamp propagation updates parent folders automatically when:
- documents are uploaded
- notes are edited
- subfolders are created

---

# Architecture

## Folder Structure

lib/
├── database/
├── models/
├── providers/
├── screens/
├── services/
├── utils/
└── widgets/

---

# Core Architecture

## Recursive Explorer System

Folders can contain:
- subfolders
- documents

Folder navigation recursively reuses the same FolderScreen.

---

## Document Types

DocumentModel supports:

- pdf
- image
- text

Different document types use specialized screens.

---

## Local File-Based Storage

Files are stored physically in local app storage.

Examples:

AppDocuments/
 ├── Finance/
 │     ├── pan.pdf
 │     ├── bank.jpg
 │     └── passwords.txt

---

# Technologies Used

- Flutter
- Dart
- Isar Database
- Provider
- File Picker
- Path Provider
- Syncfusion PDF Viewer
- Photo View

---

# Current Progress

## Completed

### V1 Phase 1
- Project setup
- Theme setup
- Navigation setup

### V1 Phase 2
- Category system
- Home screen
- Folder navigation
- Local database setup

### V1 Phase 3
- Document upload
- Local file storage
- Document viewer
- Recursive folder architecture
- Multi-action explorer FAB

### Modification 1
- Nested folders
- Recursive hierarchy
- Recursive timestamp propagation

### Modification 2 (In Progress)
- Editable text notes
- Auto-save architecture
- Text editor screen

---

# Future Plans

- Search system
- Smart document suggestions
- Missing document detection
- Encryption
- Cloud sync
- OCR support
- Tags & filters
- Recent activity dashboard

---

# Design Philosophy

This project focuses on:

- Offline-first architecture
- Scalable recursive explorer design
- File-based storage system
- Simple and clean UI
- Extensible document architecture

---

# Status

Project currently under active development.