# D-files Website

Welcome to the D-files Website! This platform allows users to upload various types of files such as photos, videos, documents, etc. The uploaded content is accessible to the admin through a separate app.

## Features

- **User Registration and Login**: Users can sign up and log in to their accounts.
- **File Upload**: Users can upload photos, videos, documents, and other file types.
- **User Profile**: Each user has a profile where they can manage their uploaded files.

## Technology Stack

- **Frontend**: Flutter Web
- **Backend**: Firebase

## Setup and Installation

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Firebase Project: [Create a Firebase project](https://firebase.google.com/)

### Installation Steps

1. **Clone the Repository**:
    ```sh
    git clone https://github.com/yourusername/user-upload-website.git
    cd user-upload-website
    ```

2. **Set Up Firebase**:
    - Create a new Firebase project.
    - Add a web app to your Firebase project.
    - Copy the Firebase configuration settings to your Flutter web app.

3. **Configure Firebase in Flutter**:
    - Replace the Firebase configuration in `web/index.html` with your Firebase project configuration.

4. **Install Dependencies**:
    ```sh
    flutter pub get
    ```

5. **Run the App**:
    ```sh
    flutter run -d chrome
    ```

## Usage

1. **Register/Login**: Create an account or log in with existing credentials.
2. **Upload Files**: Use the upload button to add photos, videos, documents, or other files.
3. **Manage Files**: View and manage your uploaded files in your user profile.

## Contributing

We welcome contributions! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature/your-feature-name`.
3. Commit your changes: `git commit -m 'Add some feature'`.
4. Push to the branch: `git push origin feature/your-feature-name`.
5. Create a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
