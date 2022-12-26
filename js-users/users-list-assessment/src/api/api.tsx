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

  async getUserById(id: string) {
    const user = await fetch(
      `https://assessment-users-backend.herokuapp.com/users/${id}`,
      {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      }
    );
    return await user.json();
  },

  async updateStatusById(
    id: number,
    statusUpdate: statusUpdate
  ) {
    await fetch(`https://assessment-users-backend.herokuapp.com/users/${id}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(statusUpdate),
    });
  },

  async updateUserById(id: string, updatedUser: updatedUser) {
    await fetch(
      `https://assessment-users-backend.herokuapp.com/users/${id}`,
      {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(updatedUser),
      }
    );
  },
};