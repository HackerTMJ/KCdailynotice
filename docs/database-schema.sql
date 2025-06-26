-- Kuen Cheng High School Website Database Schema
-- Supabase PostgreSQL Implementation

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================================
-- AUTHENTICATION & USER MANAGEMENT
-- ============================================================================

-- Profiles table (extends Supabase auth.users)
CREATE TABLE profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  role TEXT DEFAULT 'viewer' CHECK (role IN ('admin', 'editor', 'viewer')),
  avatar_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS on profiles
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- CONTENT MANAGEMENT
-- ============================================================================

-- Announcements/News
CREATE TABLE announcements (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  excerpt TEXT, -- Short preview for listing pages
  slug TEXT UNIQUE NOT NULL, -- URL-friendly identifier
  featured_image_url TEXT,
  author_id UUID REFERENCES profiles(id),
  category TEXT DEFAULT 'general' CHECK (category IN ('general', 'academic', 'sports', 'events', 'urgent')),
  priority INTEGER DEFAULT 1 CHECK (priority BETWEEN 1 AND 5), -- 1=low, 5=urgent
  tags TEXT[], -- Array of tags for filtering
  visible BOOLEAN DEFAULT true,
  published_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index for performance
CREATE INDEX idx_announcements_published ON announcements(published_at DESC) WHERE visible = true;
CREATE INDEX idx_announcements_category ON announcements(category);
CREATE INDEX idx_announcements_slug ON announcements(slug);

-- Homepage Banners
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

-- Create index for banner ordering
CREATE INDEX idx_banners_order ON banners(sort_order ASC) WHERE visible = true;

-- Daily Notices
CREATE TABLE daily_notices (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  notice_date DATE NOT NULL UNIQUE,
  absent_teachers TEXT[], -- Array of absent teacher names
  reminders TEXT[], -- Array of general reminders
  activities TEXT[], -- Array of daily activities
  meal_info TEXT, -- Cafeteria information
  special_announcements TEXT[], -- Array of special notices
  attachment_url TEXT, -- Optional file attachment
  attachment_name TEXT,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index for date-based queries
CREATE INDEX idx_daily_notices_date ON daily_notices(notice_date DESC);

-- ============================================================================
-- ORGANIZATIONAL STRUCTURE
-- ============================================================================

-- School Departments
CREATE TABLE departments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  code TEXT UNIQUE, -- e.g., 'MATH', 'ENG', 'SCI'
  description TEXT,
  head_of_department UUID, -- Will reference staff_members(id) after creation
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Staff Members
CREATE TABLE staff_members (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  department_id UUID REFERENCES departments(id),
  position TEXT, -- Teacher, HOD, Principal, etc.
  email TEXT,
  phone TEXT,
  photo_url TEXT,
  bio TEXT,
  qualifications TEXT[], -- Array of qualifications
  subjects_taught TEXT[], -- Array of subjects
  years_of_experience INTEGER,
  visible BOOLEAN DEFAULT true,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add foreign key constraint for head_of_department after staff_members is created
ALTER TABLE departments 
ADD CONSTRAINT fk_departments_hod 
FOREIGN KEY (head_of_department) REFERENCES staff_members(id);

-- Create indexes for staff queries
CREATE INDEX idx_staff_department ON staff_members(department_id);
CREATE INDEX idx_staff_visible ON staff_members(visible, sort_order);

-- ============================================================================
-- EVENTS & CALENDAR
-- ============================================================================

-- School Events
CREATE TABLE events (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  event_date DATE NOT NULL,
  start_time TIME,
  end_time TIME,
  location TEXT,
  category TEXT DEFAULT 'general' CHECK (category IN ('academic', 'sports', 'cultural', 'meeting', 'holiday', 'exam')),
  color TEXT DEFAULT '#3B82F6', -- Hex color for calendar display
  all_day BOOLEAN DEFAULT false,
  recurring BOOLEAN DEFAULT false,
  recurring_pattern TEXT, -- JSON string: {"type": "weekly", "interval": 1, "end_date": "2024-12-31"}
  max_participants INTEGER,
  registration_required BOOLEAN DEFAULT false,
  visible BOOLEAN DEFAULT true,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for event queries
CREATE INDEX idx_events_date ON events(event_date) WHERE visible = true;
CREATE INDEX idx_events_category ON events(category);

-- ============================================================================
-- MEDIA & DOCUMENTS
-- ============================================================================

-- Gallery Images
CREATE TABLE gallery_images (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  image_url TEXT NOT NULL,
  thumbnail_url TEXT, -- Optimized smaller version
  caption TEXT,
  alt_text TEXT, -- For accessibility
  category TEXT DEFAULT 'general' CHECK (category IN ('events', 'campus', 'sports', 'academics', 'achievements', 'facilities')),
  event_id UUID REFERENCES events(id), -- Optional link to specific event
  tags TEXT[], -- Array of tags for filtering
  sort_order INTEGER DEFAULT 0,
  visible BOOLEAN DEFAULT true,
  uploaded_by UUID REFERENCES profiles(id),
  uploaded_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for gallery queries
CREATE INDEX idx_gallery_category ON gallery_images(category) WHERE visible = true;
CREATE INDEX idx_gallery_uploaded ON gallery_images(uploaded_at DESC);

-- Document Downloads
CREATE TABLE documents (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  file_url TEXT NOT NULL,
  file_name TEXT NOT NULL,
  file_size INTEGER, -- in bytes
  file_type TEXT, -- MIME type
  category TEXT DEFAULT 'general' CHECK (category IN ('forms', 'policies', 'handbooks', 'circulars', 'results', 'timetables', 'newsletters')),
  department_id UUID REFERENCES departments(id), -- Optional department association
  academic_year TEXT, -- e.g., '2024-2025'
  visible BOOLEAN DEFAULT true,
  download_count INTEGER DEFAULT 0,
  uploaded_by UUID REFERENCES profiles(id),
  uploaded_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for document queries
CREATE INDEX idx_documents_category ON documents(category) WHERE visible = true;
CREATE INDEX idx_documents_year ON documents(academic_year);

-- ============================================================================
-- SYSTEM MANAGEMENT
-- ============================================================================

-- Site Settings (for configuration management)
CREATE TABLE settings (
  key TEXT PRIMARY KEY,
  value JSONB NOT NULL,
  description TEXT,
  updated_by UUID REFERENCES profiles(id),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Activity Logs (for audit trail)
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

-- Create index for activity log queries
CREATE INDEX idx_activity_logs_user ON activity_logs(user_id, created_at DESC);
CREATE INDEX idx_activity_logs_table ON activity_logs(table_name, created_at DESC);

-- ============================================================================
-- FUNCTIONS & TRIGGERS
-- ============================================================================

-- Function to automatically update 'updated_at' timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply the trigger to all tables with updated_at column
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_announcements_updated_at BEFORE UPDATE ON announcements FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_banners_updated_at BEFORE UPDATE ON banners FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_daily_notices_updated_at BEFORE UPDATE ON daily_notices FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_staff_members_updated_at BEFORE UPDATE ON staff_members FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_events_updated_at BEFORE UPDATE ON events FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_settings_updated_at BEFORE UPDATE ON settings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to automatically create profile when user signs up
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name)
  VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data->>'full_name');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to create profile on signup
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Function to log activities
CREATE OR REPLACE FUNCTION log_activity()
RETURNS TRIGGER AS $$
DECLARE
    user_id_val UUID;
BEGIN
    -- Get current user ID (you might need to adjust this based on your auth setup)
    user_id_val := auth.uid();
    
    IF TG_OP = 'DELETE' THEN
        INSERT INTO activity_logs (user_id, action, table_name, record_id, old_values)
        VALUES (user_id_val, 'delete', TG_TABLE_NAME, OLD.id::TEXT, to_jsonb(OLD));
        RETURN OLD;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO activity_logs (user_id, action, table_name, record_id, old_values, new_values)
        VALUES (user_id_val, 'update', TG_TABLE_NAME, NEW.id::TEXT, to_jsonb(OLD), to_jsonb(NEW));
        RETURN NEW;
    ELSIF TG_OP = 'INSERT' THEN
        INSERT INTO activity_logs (user_id, action, table_name, record_id, new_values)
        VALUES (user_id_val, 'create', TG_TABLE_NAME, NEW.id::TEXT, to_jsonb(NEW));
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Apply activity logging triggers (only on important tables)
CREATE TRIGGER log_announcements_activity AFTER INSERT OR UPDATE OR DELETE ON announcements FOR EACH ROW EXECUTE FUNCTION log_activity();
CREATE TRIGGER log_banners_activity AFTER INSERT OR UPDATE OR DELETE ON banners FOR EACH ROW EXECUTE FUNCTION log_activity();
CREATE TRIGGER log_daily_notices_activity AFTER INSERT OR UPDATE OR DELETE ON daily_notices FOR EACH ROW EXECUTE FUNCTION log_activity();
CREATE TRIGGER log_events_activity AFTER INSERT OR UPDATE OR DELETE ON events FOR EACH ROW EXECUTE FUNCTION log_activity();
CREATE TRIGGER log_staff_activity AFTER INSERT OR UPDATE OR DELETE ON staff_members FOR EACH ROW EXECUTE FUNCTION log_activity();

-- ============================================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE announcements ENABLE ROW LEVEL SECURITY;
ALTER TABLE banners ENABLE ROW LEVEL SECURITY;
ALTER TABLE daily_notices ENABLE ROW LEVEL SECURITY;
ALTER TABLE departments ENABLE ROW LEVEL SECURITY;
ALTER TABLE staff_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE gallery_images ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE activity_logs ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Users can view all profiles" ON profiles FOR SELECT USING (true);
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = id);

-- Public read access for published content
CREATE POLICY "Anyone can view published announcements" ON announcements FOR SELECT USING (visible = true AND published_at <= NOW());
CREATE POLICY "Anyone can view active banners" ON banners FOR SELECT USING (visible = true AND (start_date IS NULL OR start_date <= NOW()) AND (end_date IS NULL OR end_date >= NOW()));
CREATE POLICY "Anyone can view daily notices" ON daily_notices FOR SELECT USING (true);
CREATE POLICY "Anyone can view departments" ON departments FOR SELECT USING (true);
CREATE POLICY "Anyone can view visible staff" ON staff_members FOR SELECT USING (visible = true);
CREATE POLICY "Anyone can view visible events" ON events FOR SELECT USING (visible = true);
CREATE POLICY "Anyone can view visible gallery images" ON gallery_images FOR SELECT USING (visible = true);
CREATE POLICY "Anyone can view visible documents" ON documents FOR SELECT USING (visible = true);

-- Admin/Editor policies for content management
CREATE POLICY "Admins can manage announcements" ON announcements USING (
  EXISTS (SELECT 1 FROM profiles WHERE profiles.id = auth.uid() AND profiles.role IN ('admin', 'editor'))
);

CREATE POLICY "Admins can manage banners" ON banners USING (
  EXISTS (SELECT 1 FROM profiles WHERE profiles.id = auth.uid() AND profiles.role IN ('admin', 'editor'))
);

CREATE POLICY "Admins can manage daily notices" ON daily_notices USING (
  EXISTS (SELECT 1 FROM profiles WHERE profiles.id = auth.uid() AND profiles.role IN ('admin', 'editor'))
);

CREATE POLICY "Admins can manage departments" ON departments USING (
  EXISTS (SELECT 1 FROM profiles WHERE profiles.id = auth.uid() AND profiles.role = 'admin')
);

CREATE POLICY "Admins can manage staff" ON staff_members USING (
  EXISTS (SELECT 1 FROM profiles WHERE profiles.id = auth.uid() AND profiles.role IN ('admin', 'editor'))
);

CREATE POLICY "Admins can manage events" ON events USING (
  EXISTS (SELECT 1 FROM profiles WHERE profiles.id = auth.uid() AND profiles.role IN ('admin', 'editor'))
);

CREATE POLICY "Admins can manage gallery" ON gallery_images USING (
  EXISTS (SELECT 1 FROM profiles WHERE profiles.id = auth.uid() AND profiles.role IN ('admin', 'editor'))
);

CREATE POLICY "Admins can manage documents" ON documents USING (
  EXISTS (SELECT 1 FROM profiles WHERE profiles.id = auth.uid() AND profiles.role IN ('admin', 'editor'))
);

-- Settings - admin only
CREATE POLICY "Only admins can view settings" ON settings FOR SELECT USING (
  EXISTS (SELECT 1 FROM profiles WHERE profiles.id = auth.uid() AND profiles.role = 'admin')
);

CREATE POLICY "Only admins can manage settings" ON settings USING (
  EXISTS (SELECT 1 FROM profiles WHERE profiles.id = auth.uid() AND profiles.role = 'admin')
);

-- Activity logs - admin only
CREATE POLICY "Only admins can view activity logs" ON activity_logs FOR SELECT USING (
  EXISTS (SELECT 1 FROM profiles WHERE profiles.id = auth.uid() AND profiles.role = 'admin')
);

-- ============================================================================
-- STORAGE POLICIES
-- ============================================================================

-- Storage bucket policies will be created separately in Supabase dashboard or via separate SQL

-- ============================================================================
-- SEED DATA
-- ============================================================================

-- Insert default departments
INSERT INTO departments (name, code, description, sort_order) VALUES
  ('Mathematics', 'MATH', 'Mathematics Department', 1),
  ('English Language', 'ENG', 'English Language Department', 2),
  ('Science', 'SCI', 'Science Department', 3),
  ('Chinese Language', 'CHI', 'Chinese Language Department', 4),
  ('Malay Language', 'BM', 'Bahasa Malaysia Department', 5),
  ('Physical Education', 'PE', 'Physical Education Department', 6),
  ('Arts', 'ART', 'Arts Department', 7),
  ('Information Technology', 'IT', 'Information Technology Department', 8),
  ('Administration', 'ADMIN', 'School Administration', 9);

-- Insert default settings
INSERT INTO settings (key, value, description) VALUES
  ('school_name', '"Kuen Cheng High School"', 'Official school name'),
  ('school_address', '"Address details here"', 'School physical address'),
  ('school_phone', '"+60-3-XXXX-XXXX"', 'School contact phone'),
  ('school_email', '"info@kuencheng.edu.my"', 'School contact email'),
  ('website_title', '"Kuen Cheng High School - Excellence in Education"', 'Website title for SEO'),
  ('maintenance_mode', 'false', 'Enable/disable maintenance mode'),
  ('announcement_auto_archive_days', '365', 'Days after which announcements are auto-archived'),
  ('max_file_upload_size', '10485760', 'Maximum file upload size in bytes (10MB)'),
  ('gallery_images_per_page', '12', 'Number of images to show per page in gallery'),
  ('daily_notice_retention_days', '90', 'Days to keep daily notices before archiving');

-- Insert a sample admin user profile (you'll need to create the auth user first)
-- This is just an example - actual user creation should be done through Supabase Auth
-- INSERT INTO profiles (id, email, full_name, role) VALUES
--   ('admin-user-uuid-here', 'admin@kuencheng.edu.my', 'Admin User', 'admin');
