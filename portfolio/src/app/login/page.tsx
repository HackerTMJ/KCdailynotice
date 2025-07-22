export default function LoginPage() {
  return (
    <div className="font-sans grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20">
      <main className="flex flex-col gap-[32px] row-start-2 items-center sm:items-start">
        <h1 className="text-2xl font-bold">Login Page</h1>
        <form className="flex flex-col gap-4 bg-white p-6 rounded shadow-md w-full max-w-sm">
          <label htmlFor="username" className="text-lg">Username:</label>
          <input
            type="text"
            id="username"
            placeholder="Username"
            className="border border-gray-300 rounded p-2" />
            <label htmlFor="password" className="text-lg">Password:</label>
            <input
              type="password"
              placeholder="Password"
              id="password"
              className="border border-gray-300 rounded p-2"
            />
            <button 
                type="submit"
                className="bg-blue-500 text-white rounded p-2 hover:bg-blue-600 transition-colors"
            >
                Login
            </button>
            <hr />
            <p className="text-sm">
              Don't have an account? <a href="/register" className="text-blue-500 hover:underline">Register</a>
            </p>
          </form>
      </main>
    </div>
  );
}