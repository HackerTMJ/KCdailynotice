# Kuen Cheng High School Website Rebuild

## 🎯 Project Overview

This project aims to rebuild the Kuen Cheng High School (KCHS) website, replacing the current Google Sites + Google Slides setup with a modern and dynamic web application built using **Next.js** and **Supabase**. This new version includes an admin dashboard for managing school content, optimized for speed, usability, and maintainability.

---

## ⚙️ Tech Stack

| Area     | Technology                            |
|----------|---------------------------------------|
| Frontend | Next.js (App Router)                  |
| Styling  | Tailwind CSS                          |
| Backend  | Supabase (DB, Storage, Auth)          |
| Auth     | Supabase Auth (Email or Google Login) |
| Hosting  | Vercel (Frontend)                     |

---

## 🌐 Public Website Features

### 🏠 Home Page
- School name, intro
- Dynamic banners (carousel)
- Latest announcements preview

### 📢 Announcements
- List of news and events
- Read full articles (stored in DB)

### 📋 Daily Notice
- Dedicated page for daily bulletin (from admin system)
- Displays:
  - Date
  - Absent teachers
  - Events & activity reminders
  - Highlighted messages
  - Meal/Cafeteria notices
  - Optional image or table attachments

### 📅 Calendar / Events
- School calendar or upcoming events

### 🖼️ Gallery
- Photo gallery (from Supabase Storage)

### 👥 Staff / Departments
- Teacher/staff info grouped by department

### 📁 Downloads
- PDF and document downloads

### 📞 Contact & Footer
- Address, map, email, quick links

---

## 🔐 Admin Dashboard Features

Accessible at `/admin` (protected by Supabase Auth):

### 🎨 Banner Management
- Add/remove homepage banners
- Upload banner images

### 📰 Announcements
- Add/edit/delete news articles

### 📋 Daily Notice Management
- Submit/edit daily notices
- Fields: absent teachers, reminders, activities, cafeteria, image upload
- Date-based entry

### 📅 Events/Calendar
- Create, edit, remove events

### 🖼️ Gallery Upload
- Upload images to Supabase storage with captions

### 📄 Document Upload
- Upload and manage PDFs or DOCs

### 👤 Staff Management
- Add/edit teacher/staff info with photo

---

## 🗃️ Supabase Database Schema

### Tables

```sql
-- announcements
id | title | content | date_posted | visible

-- banners
id | image_url | title | subtitle | link

-- gallery_images
id | image_url | caption | uploaded_at

-- documents
id | title | file_url | uploaded_at

-- events
id | title | date | description

-- staff_members
id | name | department | photo_url | bio

-- daily_notices
id | date | absent_teachers | reminders | activities | meal_info | attachment_url
```

### Storage Buckets
- `banners`
- `gallery`
- `documents`
- `staff_photos`
- `daily_notice_attachments`

---

## 🛠️ Development Phases

### Phase 1: Initial Setup
- [ ] Set up new Next.js app with Tailwind
- [ ] Connect Supabase project
- [ ] Create Supabase tables and buckets
- [ ] Configure `.env.local` for Supabase keys

### Phase 2: Public Site Pages
- [ ] Home page with dynamic banners
- [ ] News and announcements page
- [ ] Daily Notice page with formatted sections
- [ ] Gallery page with image grid
- [ ] Events/Calendar page
- [ ] Staff directory grouped by department
- [ ] Document downloads page
- [ ] Footer and contact section

### Phase 3: Admin Dashboard
- [ ] Authenticated admin login (Supabase Auth)
- [ ] Add/update/delete banners
- [ ] Create and manage announcements
- [ ] Submit and edit daily notices with attachments
- [ ] Upload and manage gallery images
- [ ] Add staff info (photo, department, bio)
- [ ] Upload downloadable documents
- [ ] Add/edit school events

### Phase 4: Polish & Launch
- [ ] Responsive design for mobile/tablet
- [ ] Form validation and error handling
- [ ] SEO and metadata setup
- [ ] Deploy frontend to Vercel
- [ ] Test admin workflow and database permissions

---

## 🗂️ Suggested Folder Structure

```
/app
  /admin
    /banners
    /announcements
    /gallery
    /staff
    /daily-notice
  /news
  /gallery
  /staff
  /downloads
/components
  Banner.tsx
  NewsCard.tsx
  GalleryGrid.tsx
  DailyNotice.tsx
  Layout.tsx
/lib
  supabaseClient.ts
/public
/styles
  globals.css
```

---

## ✅ Final Goals

- ✨ Modern, responsive, fast-loading school website
- 🎛️ Easy admin interface for content updates
- 🚫 No reliance on external tools like Google Slides
- 🚀 Hosted and managed efficiently via Supabase and Vercel

---

## 💡 Tips

- Use Supabase row-level security (RLS) to protect content
- Use Tailwind's responsive utilities for mobile-first UI
- Optimize image loading with Next.js `<Image />` component

---

> **Ready to start?** Let me know when you're ready to generate the starter code or admin dashboard!

## 🗂️ Optimal Folder Structure

```
kchs-website/
├── app/
│   ├── (auth)/
│   │   └── login/
│   │       └── page.tsx
│   ├── (public)/
│   │   ├── page.tsx                    # Home page
│   │   ├── announcements/
│   │   │   ├── page.tsx               # Announcements list
│   │   │   └── [id]/
│   │   │       └── page.tsx           # Individual announcement
│   │   ├── daily-notice/
│   │   │   ├── page.tsx               # Latest daily notice
│   │   │   └── [date]/
│   │   │       └── page.tsx           # Specific date notice
│   │   ├── gallery/
│   │   │   └── page.tsx
│   │   ├── staff/
│   │   │   ├── page.tsx               # Staff directory
│   │   │   └── [department]/
│   │   │       └── page.tsx           # Department staff
│   │   ├── events/
│   │   │   ├── page.tsx               # Events calendar
│   │   │   └── [id]/
│   │   │       └── page.tsx           # Event details
│   │   ├── downloads/
│   │   │   └── page.tsx
│   │   └── contact/
│   │       └── page.tsx
│   ├── admin/
│   │   ├── layout.tsx                 # Admin layout with auth
│   │   ├── page.tsx                   # Admin dashboard
│   │   ├── banners/
│   │   │   ├── page.tsx               # Banner management
│   │   │   ├── new/
│   │   │   │   └── page.tsx
│   │   │   └── [id]/
│   │   │       ├── page.tsx           # Edit banner
│   │   │       └── delete/
│   │   │           └── page.tsx
│   │   ├── announcements/
│   │   │   ├── page.tsx               # Announcements management
│   │   │   ├── new/
│   │   │   │   └── page.tsx
│   │   │   └── [id]/
│   │   │       ├── page.tsx           # Edit announcement
│   │   │       └── delete/
│   │   │           └── page.tsx
│   │   ├── daily-notice/
│   │   │   ├── page.tsx               # Daily notice management
│   │   │   ├── new/
│   │   │   │   └── page.tsx
│   │   │   └── [date]/
│   │   │       ├── page.tsx           # Edit daily notice
│   │   │       └── delete/
│   │   │           └── page.tsx
│   │   ├── events/
│   │   │   ├── page.tsx
│   │   │   ├── new/
│   │   │   │   └── page.tsx
│   │   │   └── [id]/
│   │   │       ├── page.tsx
│   │   │       └── delete/
│   │   │           └── page.tsx
│   │   ├── gallery/
│   │   │   ├── page.tsx
│   │   │   ├── upload/
│   │   │   │   └── page.tsx
│   │   │   └── [id]/
│   │   │       ├── page.tsx
│   │   │       └── delete/
│   │   │           └── page.tsx
│   │   ├── staff/
│   │   │   ├── page.tsx
│   │   │   ├── new/
│   │   │   │   └── page.tsx
│   │   │   └── [id]/
│   │   │       ├── page.tsx
│   │   │       └── delete/
│   │   │           └── page.tsx
│   │   └── documents/
│   │       ├── page.tsx
│   │       ├── upload/
│   │       │   └── page.tsx
│   │       └── [id]/
│   │           ├── page.tsx
│   │           └── delete/
│   │               └── page.tsx
│   ├── api/
│   │   ├── auth/
│   │   │   └── callback/
│   │   │       └── route.ts           # Supabase auth callback
│   │   ├── banners/
│   │   │   ├── route.ts               # GET, POST banners
│   │   │   └── [id]/
│   │   │       └── route.ts           # PUT, DELETE banner
│   │   ├── announcements/
│   │   │   ├── route.ts
│   │   │   └── [id]/
│   │   │       └── route.ts
│   │   ├── daily-notices/
│   │   │   ├── route.ts
│   │   │   └── [date]/
│   │   │       └── route.ts
│   │   ├── events/
│   │   │   ├── route.ts
│   │   │   └── [id]/
│   │   │       └── route.ts
│   │   ├── gallery/
│   │   │   ├── route.ts
│   │   │   └── [id]/
│   │   │       └── route.ts
│   │   ├── staff/
│   │   │   ├── route.ts
│   │   │   └── [id]/
│   │   │       └── route.ts
│   │   ├── documents/
│   │   │   ├── route.ts
│   │   │   └── [id]/
│   │   │       └── route.ts
│   │   └── upload/
│   │       └── route.ts               # File upload handler
│   ├── globals.css
│   ├── layout.tsx                     # Root layout
│   └── loading.tsx                    # Global loading component
├── components/
│   ├── ui/                           # Shadcn/ui components
│   │   ├── button.tsx
│   │   ├── input.tsx
│   │   ├── textarea.tsx
│   │   ├── select.tsx
│   │   ├── dialog.tsx
│   │   ├── toast.tsx
│   │   ├── card.tsx
│   │   ├── badge.tsx
│   │   └── loading-spinner.tsx
│   ├── layout/
│   │   ├── Header.tsx
│   │   ├── Footer.tsx
│   │   ├── Navigation.tsx
│   │   ├── AdminSidebar.tsx
│   │   └── MobileMenu.tsx
│   ├── home/
│   │   ├── HeroBanner.tsx
│   │   ├── BannerCarousel.tsx
│   │   ├── LatestAnnouncements.tsx
│   │   ├── QuickLinks.tsx
│   │   └── SchoolStats.tsx
│   ├── announcements/
│   │   ├── AnnouncementCard.tsx
│   │   ├── AnnouncementList.tsx
│   │   ├── AnnouncementDetail.tsx
│   │   └── AnnouncementForm.tsx
│   ├── daily-notice/
│   │   ├── DailyNoticeCard.tsx
│   │   ├── DailyNoticeDisplay.tsx
│   │   ├── DailyNoticeForm.tsx
│   │   └── NoticeAttachment.tsx
│   ├── events/
│   │   ├── EventCard.tsx
│   │   ├── EventCalendar.tsx
│   │   ├── EventList.tsx
│   │   └── EventForm.tsx
│   ├── gallery/
│   │   ├── GalleryGrid.tsx
│   │   ├── ImageCard.tsx
│   │   ├── ImageModal.tsx
│   │   └── ImageUpload.tsx
│   ├── staff/
│   │   ├── StaffCard.tsx
│   │   ├── StaffGrid.tsx
│   │   ├── DepartmentFilter.tsx
│   │   └── StaffForm.tsx
│   ├── documents/
│   │   ├── DocumentCard.tsx
│   │   ├── DocumentList.tsx
│   │   └── DocumentUpload.tsx
│   ├── admin/
│   │   ├── AdminStats.tsx
│   │   ├── QuickActions.tsx
│   │   ├── RecentActivity.tsx
│   │   └── DataTable.tsx
│   └── forms/
│       ├── FormField.tsx
│       ├── ImageUploadField.tsx
│       ├── RichTextEditor.tsx
│       └── DatePicker.tsx
├── lib/
│   ├── supabase/
│   │   ├── client.ts                 # Client-side Supabase
│   │   ├── server.ts                 # Server-side Supabase
│   │   ├── auth.ts                   # Auth helpers
│   │   └── storage.ts                # Storage helpers
│   ├── utils/
│   │   ├── cn.ts                     # Class name utility
│   │   ├── date.ts                   # Date formatting
│   │   ├── validation.ts             # Form validation schemas
│   │   └── file-upload.ts            # File upload utilities
│   ├── hooks/
│   │   ├── useAuth.ts
│   │   ├── useLocalStorage.ts
│   │   └── useDebounce.ts
│   └── constants/
│       ├── navigation.ts
│       ├── departments.ts
│       └── file-types.ts
├── types/
│   ├── database.ts                   # Supabase generated types
│   ├── auth.ts
│   ├── forms.ts
│   └── common.ts
├── public/
│   ├── images/
│   │   ├── logo.png
│   │   ├── favicon.ico
│   │   └── placeholder.jpg
│   └── icons/
│       ├── departments/
│       └── social/
├── styles/
│   └── globals.css
├── middleware.ts                     # Auth middleware
├── next.config.js
├── tailwind.config.js
├── components.json                   # Shadcn/ui config
├── package.json
├── .env.local
├── .env.example
├── .gitignore
├── README.md
└── supabase/
    ├── migrations/
    │   ├── 001_initial_schema.sql
    │   ├── 002_rls_policies.sql
    │   └── 003_storage_buckets.sql
    └── seed.sql
```

---

## 🗄️ Enhanced Database Schema

### Core Tables

```sql
-- profiles (extends Supabase auth.users)
CREATE TABLE profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  role TEXT DEFAULT 'viewer' CHECK (role IN ('admin', 'editor', 'viewer')),
  avatar_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- announcements
CREATE TABLE announcements (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  excerpt TEXT, -- Short preview for listing
  slug TEXT UNIQUE NOT NULL, -- URL-friendly identifier
  featured_image_url TEXT,
  author_id UUID REFERENCES profiles(id),
  category TEXT DEFAULT 'general' CHECK (category IN ('general', 'academic', 'sports', 'events', 'urgent')),
  priority INTEGER DEFAULT 1 CHECK (priority BETWEEN 1 AND 5), -- 1=low, 5=urgent
  visible BOOLEAN DEFAULT true,
  published_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- banners
CREATE TABLE banners (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  subtitle TEXT,
  image_url TEXT NOT NULL,
  link_url TEXT,
  link_text TEXT,
  sort_order INTEGER DEFAULT 0,
  visible BOOLEAN DEFAULT true,
  start_date TIMESTAMPTZ,
  end_date TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- daily_notices
CREATE TABLE daily_notices (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  notice_date DATE NOT NULL UNIQUE,
  absent_teachers TEXT[],
  reminders TEXT[],
  activities TEXT[],
  meal_info TEXT,
  special_announcements TEXT[],
  attachment_url TEXT,
  attachment_name TEXT,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- events
CREATE TABLE events (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  event_date DATE NOT NULL,
  start_time TIME,
  end_time TIME,
  location TEXT,
  category TEXT DEFAULT 'general' CHECK (category IN ('academic', 'sports', 'cultural', 'meeting', 'holiday', 'exam')),
  color TEXT DEFAULT '#3B82F6', -- For calendar display
  all_day BOOLEAN DEFAULT false,
  recurring BOOLEAN DEFAULT false,
  recurring_pattern TEXT, -- daily, weekly, monthly, yearly
  max_participants INTEGER,
  registration_required BOOLEAN DEFAULT false,
  visible BOOLEAN DEFAULT true,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- departments
CREATE TABLE departments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  code TEXT UNIQUE, -- e.g., 'MATH', 'ENG', 'SCI'
  description TEXT,
  head_of_department UUID REFERENCES staff_members(id),
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- staff_members
CREATE TABLE staff_members (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  department_id UUID REFERENCES departments(id),
  position TEXT, -- Teacher, HOD, Principal, etc.
  email TEXT,
  phone TEXT,
  photo_url TEXT,
  bio TEXT,
  qualifications TEXT[],
  subjects_taught TEXT[],
  years_of_experience INTEGER,
  visible BOOLEAN DEFAULT true,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- gallery_images
CREATE TABLE gallery_images (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  image_url TEXT NOT NULL,
  thumbnail_url TEXT,
  caption TEXT,
  alt_text TEXT,
  category TEXT DEFAULT 'general' CHECK (category IN ('events', 'campus', 'sports', 'academics', 'achievements')),
  event_id UUID REFERENCES events(id), -- Link to specific event
  sort_order INTEGER DEFAULT 0,
  visible BOOLEAN DEFAULT true,
  uploaded_by UUID REFERENCES profiles(id),
  uploaded_at TIMESTAMPTZ DEFAULT NOW()
);

-- documents
CREATE TABLE documents (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  file_url TEXT NOT NULL,
  file_name TEXT NOT NULL,
  file_size INTEGER, -- in bytes
  file_type TEXT, -- PDF, DOC, etc.
  category TEXT DEFAULT 'general' CHECK (category IN ('forms', 'policies', 'handbooks', 'circulars', 'results', 'timetables')),
  department_id UUID REFERENCES departments(id),
  visible BOOLEAN DEFAULT true,
  download_count INTEGER DEFAULT 0,
  uploaded_by UUID REFERENCES profiles(id),
  uploaded_at TIMESTAMPTZ DEFAULT NOW()
);

-- settings (for site configuration)
CREATE TABLE settings (
  key TEXT PRIMARY KEY,
  value JSONB NOT NULL,
  description TEXT,
  updated_by UUID REFERENCES profiles(id),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- activity_logs (for admin tracking)
CREATE TABLE activity_logs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES profiles(id),
  action TEXT NOT NULL, -- create, update, delete, login, etc.
  table_name TEXT,
  record_id TEXT,
  old_values JSONB,
  new_values JSONB,
  ip_address INET,
  user_agent TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

### Storage Buckets Configuration

```sql
-- Create storage buckets
INSERT INTO storage.buckets (id, name, public) VALUES 
  ('banners', 'banners', true),
  ('gallery', 'gallery', true),
  ('documents', 'documents', true),
  ('staff-photos', 'staff-photos', true),
  ('daily-notice-attachments', 'daily-notice-attachments', true),
  ('announcements', 'announcements', true);
```
