import react from 'react';

export default function registerPage() {
    return (
        <div className="font-sans grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20">
        <main className="flex flex-col gap-[32px] row-start-2 items-center sm:items-start">
            <h1 className="text-2xl font-bold text-white">Register Page</h1>
            <form className='flex flex-col gap-4 bg-white dark:bg-gray-800 p-6 rounded shadow-md width-100 h-120'>
                            <label htmlFor="username" className="text-lg">Username:</label>

                <input
                    type="text"
                    id="username"
                    placeholder="Username"
                    className="border border-gray-300 rounded p-2 w-full max-w-xs"
                />
                <label htmlFor="email" className="text-lg">Email:</label>

                <input
                    type="email"
                    placeholder="Email"
                    id='email'
                    className="border border-gray-300 rounded p-2 w-full max-w-xs"
                />
                 <label htmlFor="password" className="text-lg">Password:</label>

                <input
                    type="password"
                    placeholder="Password"
                    id='password'
                    className="border border-gray-300 rounded p-2 w-full max-w-xs"
                />
                
                <label htmlFor="" className="text-sm">
                    <input type="checkbox" name="" id="" />
                    I agree to the terms and conditions
                </label>
                <button
                    type="submit"
                    className="bg-blue-500 text-white rounded p-2 hover:bg-blue-600 transition-colors"
                >
                    Register
                </button>
                <hr/>
                <p className="text-sm">
                    Already have an account? <a href="/login" className="text-blue-500 hover:underline">Login</a>
                </p>
            </form>
        </main>
        </div>
    );
}