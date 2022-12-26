type newUser = {
  first_name: string;
  last_name: string;
  status: string;
};

type updatedUser = {
  first_name: string;
  last_name: string;
};

type statusUpdate = {
  status: string;
};


export const api = {
  async getAllUsers() {
    const users = await fetch(
      "https://assessment-users-backend.herokuapp.com/users",
      {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      }
    );
    return await users.json();
  },
  async addNewUser(newUser: newUser) {
    await fetch("https://assessment-users-backend.herokuapp.com/users", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(newUser),
    });
  },
};