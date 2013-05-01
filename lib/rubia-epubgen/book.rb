# coding: utf-8

module Rubia
  module Epubgen
    TMP_DIR = './tmp'
    class Book
      def initialize(name, dir)
        raise 'ディレクトリがない' unless Dir.exists?(dir)

        @name = name
        @dir = dir
        @toc_path = [dir, 'toc.yml'].join('/')
        @data_dir  = [dir, 'data'].join('/')
        @metadata_path = [dir, 'metadata.yml'].join('/')
        @ignore_filenames = ['.', '..']

        check_files()
      end

      def to_epub(out_path)
        tmp_dir = [Rubia::Epubgen::TMP_DIR, @name].join('/')
        tmp_data_dir = [Rubia::Epubgen::TMP_DIR, @name, 'data'].join('/')
        FileUtils::rm_rf(tmp_dir) if Dir::exists?(tmp_dir)
        FileUtils.mkdir_p(tmp_dir)
        FileUtils.mkdir_p(tmp_data_dir)
        File::delete(out_path) if File::exists?(out_path)

        Zip::Archive.open(out_path, Zip::CREATE) do |archive|
          data_dir = [@name.to_s, 'data'].join('/')

          archive.add_dir(@name.to_s)

          add_archive(archive, @dir, '')
        end
      end

      private
      def add_archive(archive, source, dist)
        already_write = []

        Dir.glob(source+'/**/*').each do |entry|
          next unless @ignore_filenames.index(entry).nil?

          new_dist = entry.gsub(source, '').gsub('//', '/').gsub(/^\//, '')
          next unless already_write.index(new_dist).nil?

          if File.directory?(entry)
            archive.add_dir(dist.to_s+new_dist)
          else
            archive.add_buffer(dist+new_dist, open(entry).read)
          end
          already_write << new_dist
        end
      end

      def check_files
        [@toc_path, @data_dir, @metadata_path].each do |path|
          raise "#{path}が存在しない" unless File.exists?(path)
        end
      end
    end
  end
end
