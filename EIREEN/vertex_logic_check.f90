program vertex_logic_check
    implicit none
!
        double precision, dimension(:,:),allocatable :: knots_EIRENE
        integer, dimension(:,:), allocatable :: triangles_EIRENE, triangle_back_interp_EIRENE
    !
        integer :: i
        integer :: file_id_knots,file_id_triangles,file_id_triangle_back_interp
        integer, dimension(2) :: shape_knots,shape_triangles,shape_triangle_back_interp
        character(50) :: filename_knots,filename_triangles,filename_triangle_back_interp
!
!
        !Initialize GORILLA
        call initialize_gorilla()
!
        !---------------------------------------------------------------------------------------------------------------------!
        !Load EIRENE mesh data
!
        !Define file ids and filenames for EIRENE mesh data
        file_id_knots = 501
        filename_knots = 'knots.dat'
!
        file_id_triangles = 502
        filename_triangles = 'triangles.dat'
!
        file_id_triangle_back_interp = 503
        filename_triangle_back_interp = 'triangle_back_interp.dat'
!
        !Load knots
        open(unit=file_id_knots, file=filename_knots, status='unknown')
        read(file_id_knots,*) shape_knots
        allocate(knots_EIRENE(shape_knots(1),shape_knots(2)))
        do i = 1,shape_knots(1)
            read(file_id_knots,*) knots_EIRENE(i,:)
        enddo
        close(file_id_knots)
!print *, 'knots_EIRENE(shape_knots(1),:)',knots_EIRENE(shape_knots(1),:)
!
        !Load triangles
        open(unit=file_id_triangles, file=filename_triangles, status='unknown')
        read(file_id_triangles,*) shape_triangles
        allocate(triangles_EIRENE(shape_triangles(1),shape_triangles(2)))
        do i = 1,shape_triangles(1)
            read(file_id_triangles,*) triangles_EIRENE(i,:)
        enddo
        close(file_id_triangles)
print *, 'triangles_EIRENE(1,:)',triangles_EIRENE(1,:)
!
        !Load triangle_back_interp
        open(unit=file_id_triangle_back_interp, file=filename_triangle_back_interp, status='unknown')
        read(file_id_triangle_back_interp,*) shape_triangle_back_interp
        allocate(triangle_back_interp_EIRENE(shape_triangle_back_interp(1),shape_triangle_back_interp(2)))
        do i = 1,shape_triangle_back_interp(1)
            read(file_id_triangle_back_interp,*) triangle_back_interp_EIRENE(i,:)
        enddo
        close(file_id_triangle_back_interp)
print *, 'triangle_back_interp_EIRENE(shape_triangle_back_interp(1))',triangle_back_interp_EIRENE(shape_triangle_back_interp(1),1)
!
    
end program vertex_logic_check